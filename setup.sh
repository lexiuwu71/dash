#!/bin/sh

chmod +x $(find | grep .sh)

# 0.0.0
# version, minor, patch
# devlopment, alpha, beta, release
DASH_VERSION="v0.1d"
ALPINE_VERSION="v3.22"
HOSTNAME="dash"
YEAR="2025"

BACK_TITLE="Digital Access and Service Hub Setup"
	
echo "Updating repositories, and installing some system apps..."
echo -e "#/media/cdrom/apks\nhttps://dl-cdn.alpinelinux.org/alpine/${ALPINE_VERSION}/main\nhttps://dl-cdn.alpinelinux.org/alpine/${ALPINE_VERSION}/community" > /etc/apk/repositories
./install_packages.sh "sys"
	
if (whiptail --title "* Warning *" --backtitle "$BACK_TITLE" --yesno "This setup script will heavily modify your Alpine Linux install!\nContinue?" 10 70); then
	echo "Installing..."
else
	echo "Abort!"
	exit 1
fi

# setup tty font
echo -e "consolefont=\"ter-132n.psf.gz\"" > /etc/conf.d/consolefont
rc-update add consolefont boot

# setup branding
echo -e "NAME=\"D.A.S.H\"\nID=alpine\nVERSION_ID=$DASH_VERSION\nPRETTY_NAME=\"Digital Access and Service Hub $DASH_VERSION ($ALPINE_VERSION)\"\nHOME_URL=\"https://lexiuwu71.neocities.org/dash\"\nBUG_REPORT_URL=\"https://gitlab.alpinelinux.org/alpine/aports/-/issues\"" > /etc/os-release

echo -e "$(clear)Welcome to Digital Access and Service Hub $DASH_VERSION ($ALPINE_VERSION)" > /etc/issue
cat << EOF >> /etc/issue
Kernel \r on \m (\l)
EOF
echo -e "" >> /etc/issue

echo "$HOSTNAME" > /etc/hostname

echo "$(clear)" > /etc/motd
cat files/welcome >> /etc/motd
echo -e "Welcome to D.A.S.H\n\tDigital Access and Service Hub (C) 2023-$YEAR\n\nType 'help' for a list of commands\n\n" >> /etc/motd

# set profile
rm /etc/profile
cp files/profile /etc/profile

cpu=$(whiptail --title "CPU Microcode" --backtitle "$BACK_TITLE" \
--radiolist "Choose CPU Microcode to install" 10 70 2 \
"amd" "AMD CPU" OFF \
"intel" "Intel CPU" OFF \
3>&1 1>&2 2>&3)
apk add "$cpu-ucode"

pkg_profiles=$(whiptail --title "Packages" --backtitle "$BACK_TITLE" \
--checklist "Choose Profile (which packages to install)" 10 70 4 \
"hypr" "Hyprland Desktop" ON \
"music" "Music Server (mpd)" ON \
"silly" "Silly terminal tools" ON \
"desktop" "Desktop Applications" ON \
3>&1 1>&2 2>&3)
for item in $pkg_profiles; do
	./install_packages.sh $(echo "$item" |  tr -d '"')
done

apk fix

# copy skel
rm -rf /etc/skel
mkdir -p /etc/skel
cp -r files/skel/* /etc/skel

# setup user
STEP="User setup"
echo "permit persist :wheel" > /etc/doas.conf
if whiptail --title "$STEP" --backtitle "$BACK_TITLE" --yesno "Would you like to create a user account?" 10 70; then
	username=$(whiptail --inputbox "Choose a username:" 10 70 --title "$STEP" --backtitle "$BACK_TITLE" 3>&1 1>&2 2>&3)
	password=$(whiptail --passwordbox "Choose a password:" 10 70 --title "$STEP" --backtitle "$BACK_TITLE" 3>&1 1>&2 2>&3)
	adduser "$username"
	echo "$username:$password" | chpasswd

	if whiptail --title "$STEP" --backtitle "$BACK_TITLE" --yesno "Would you like this user to be root? (wheel group)" 10 70; then
		addgroup $username wheel
	fi
else
	echo "ask if any user wants to be admin user"
fi

if whiptail --title "Hostname" --backtitle "$BACK_TITLE" --yesno "Would you like to choose a custom hostname?" 10 70; then
	hostname=$(whiptail --inputbox "Choose a hostname:" 10 70 --title "$STEP" --backtitle "$BACK_TITLE" 3>&1 1>&2 2>&3)
	echo "$hostname" > /etc/hostname
fi