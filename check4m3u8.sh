#!/bin/sh
# place script in /storage/.kodi/userdata/addon_data/service.downloadmanager.pyload/scripts/download_finished/

# task spooler info - https://github.com/justanhduc/task-spooler
# https://packages.debian.org/sid/task-spooler

export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_ALL="en_US.UTF-8"

export PATH=$PATH:/storage/.apps/bin       # exports path to locate youtube-dl binary
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/storage/.kodi/addons/tools.ffmpeg-tools/lib  # exports path to locate ffmpeg libraries

tempfolder="/storage/downloads/incomplete/"  # working folder while downloading
downloadPATH="/var/media/WD1500GB/Media/Video/Downloads/"  # location of final destination to move downloads

filename=$2
extension="${filename##*.}"
filepath="/storage/downloads/incomplete/*.m3u8"  # sets temp filepath variable in case some unforeseen error causes $3 argument to be blank
filepath=$3
fileURL=$5
package="${6//:/}"  # removes any colons from package name

ytdlLOG="/storage/.apps/youtube-dl/log.txt"  # location of youtube-dl log file
folderpath="$tempfolder""$package" # location of pyload download folder and package subfolder

touch /storage/.apps/youtube-dl/urls.txt  # optional if you want to keep a history of the urls downloaded
echo "$fileURL" >> /storage/.apps/youtube-dl/urls.txt

   if [ $extension = "m3u8" ]; then  # if filename extension downloaded by pyload is m3u8, then call youtube-dl
        cd "$tempfolder"
	rm -r "$folderpath"
	touch "$ytdlLOG"
	# Use following command to download directly as MP4 (can't watch until finished)
	# youtube-dl -f mp4 -o "$package".mp4 "$fileURL" --exec "mv -n {} "$downloadPATH"" > "$ytdlLOG" 2>&1 &
	
	# Use following command to download as MPEG-TS (Watchable while downloading) and remux back to MP4 (playable by ROKU)
	# youtube-dl --hls-use-mpegts --no-part -f mp4 -o "$package".mp4 "$fileURL" --exec "ffmpeg -i {} -c copy "$downloadPATH"{} && rm {}" > "$ytdlLOG" 2>&1 &
	
	# Use the following command to invoke tsp task spooler to create a separate task for each download (creates logs in /tmp folder)
	tsp youtube-dl --hls-use-mpegts --no-part -f mp4 -o "$package".mp4 "$fileURL" --exec "ffmpeg -i {} -c copy "$downloadPATH"{} && rm {}" &
   fi

mv -n "$folderpath" "$downloadPATH""$package"

done


