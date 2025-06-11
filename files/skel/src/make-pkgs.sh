working_directory=$(pwd)
cd /usr/local/src/src

function no_exist {
	echo "[ERROR] Package not found: '$1'"
}

function check {
	if which $1 > /dev/null 2>&1; then
		echo "[DONE] '$1' built and installed!"
	else
    		echo "[ERROR] '$1' not installed :<"
	fi
}

# Install Desktop
pkg="sxwm"
if [ -d $pkg ]; then
	# Install dependencies:
	apk add libx11-dev libxft-dev libxinerama-dev gcc make musl-dev

	# Go to src
	cd ${pkg}

	# Build:
	make clean install 

	cd ..
else
	no_exist $pkg
fi

pkg="sxbar"
if [ -d $pkg ]; then
	# Go to src
	cd ${pkg}

	# Build:
	make clean install 

	cd ..
else
	no_exist $pkg
fi
# Done installing Desktop

pkg="uwufetch"
if [ -d $pkg ]; then
	# Install dependencies:
	apk add git gcc make musl-dev

	# Go to src
	cd ${pkg}

	# Build:
	make build
	make install

	cd ..

	check $pkg
else
	no_exist $pkg
fi

pkg="tty-clock"
if [ -d $pkg ]; then
	# Install dependencies:
	apk add make gcc ncurses ncurses-dev musl-dev

	# Go to src
	cd ${pkg}

	# Build:
	make build
	make install

	cd ..

	check $pkg
else
	no_exist $pkg
fi

cd $working_directory
