#!/usr/bin/python

import subprocess

ICON_PATH = "/home/lexi/scripts/osd/volume"
NUM_STAGES = 3

def get_volume():
    volume = int(subprocess.check_output(["pamixer", "--get-volume"]).decode().strip())
    mute = subprocess.check_output(["pamixer", "--get-mute"]).decode().strip()
    return volume, mute

def get_icon(percentage):
    stage = min(NUM_STAGES - 1, int(percentage / 100 * NUM_STAGES))
    return f"{ICON_PATH}/{stage}.svg"

def notify_volume(percentage, mute):
    if mute == 'false':
        icon = get_icon(percentage)
    else:
        icon = f"{ICON_PATH}/mute.svg"
    subprocess.run([
        "notify-send",
        "Volume",
        "-a", "volume",
        "-h", "string:x-dunst-stack-tag:volume",
        f"-h", f"int:value:{percentage}",
        "-i", icon,
        f"{percentage}%"
    ])

def main():
    try:
        volume, mute = get_volume()
        notify_volume(volume, mute)
    except Exception as e:
        print("Error:", e)
        print("Make sure 'pamixer' and 'notify-send' are installed and working.")

if __name__ == "__main__":
    main()
