#!/usr/bin/python

import subprocess

ICON_PATH = "/home/lexi/scripts/osd/brightness"
NUM_STAGES = 7

def get_brightness():
    current = int(subprocess.check_output(["brightnessctl", "g"]).decode().strip())
    maximum = int(subprocess.check_output(["brightnessctl", "m"]).decode().strip())
    return current, maximum

def get_icon(percentage):
    stage = min(NUM_STAGES - 1, int(percentage / 100 * NUM_STAGES))
    return f"{ICON_PATH}/{stage+1}.svg"

def notify_brightness(percentage):
    icon = get_icon(percentage)
    subprocess.run([
        "notify-send",
        "Brightness",
        "-a", "brightness",
        "-h", "string:x-dunst-stack-tag:brightness",
        f"-h", f"int:value:{percentage}",
        "-i", icon,
        f"{percentage}%"
    ])

def main():
    try:
        current, maximum = get_brightness()
        percentage = int((current / maximum) * 100)
        notify_brightness(percentage)
    except Exception as e:
        print("Error:", e)
        print("Make sure 'brightnessctl' and 'notify-send' are installed and working.")

if __name__ == "__main__":
    main()
