STEP=5

direction=$1

if [[ "$direction" == "u" ]]; then
    brightnessctl s "${STEP}%+"
elif [[ "$direction" == "d" ]]; then
    brightnessctl s "${STEP}%-"
else
    echo "Usage: $0 [u|d]"
    exit 1
fi

python /home/lexi/scripts/brightness-osd.py
