import time
import subprocess
from pypresence import Presence

DISCORD_CLIENT_ID = '1223344645908729867'
UPDATE_INTERVAL = 15

def get_mpd_metadata():
    artist, title, album = "Unknown", "Unknown", "Unknown"
    is_playing = False

    try:
        metadata = subprocess.check_output(
            ["mpc", "current", "-f", "%artist%\\n%title%\\n%album%"]).decode().strip().splitlines()
        if len(metadata) >= 3:
            artist, title, album = metadata[:3]
        status = subprocess.check_output(["mpc", "status"]).decode().lower()
        is_playing = "[playing]" in status
    except subprocess.CalledProcessError:
        pass

    return is_playing, artist, title, album

def main():
    rpc = Presence(DISCORD_CLIENT_ID)
    rpc.connect()
    print("Connected to Discord RPC.")

    last_track = None

    while True:
        status, artist, title, album = get_mpd_metadata()

        if status and artist and title:
            current_track = f"{artist} - {title}"

            if current_track != last_track or status != True:
                state_text = f"{artist} - {title}"
                rpc.update(
                    details=f"{title}",
                    state=f"by {artist}",
                    large_image="",
                    large_text="",
                    start=int(time.time()) if status == True else None
                )
                last_track = current_track
        else:
            rpc.clear()

        time.sleep(UPDATE_INTERVAL)

if __name__ == "__main__":
    main()
