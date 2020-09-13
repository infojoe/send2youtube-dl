#!/bin/sh

export PATH=$PATH:/storage/.apps/bin       # exports path to locate youtube-dl binary
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/storage/.kodi/addons/tools.ffmpeg-tools/lib  # exports path to locate ffmpeg libraries

filename=$2
# extension="${filename##*.}" 
filepath="/storage/downloads/incomplete/*.m3u8"  # sets temp filepath variable in case some unforeseen error causes $3 argument to be blank
filepath=$3
fileURL=$5
package=$6
folderpath="/storage/downloads/incomplete/"$package # location of pyload download folder and package subfolder
ytdlLOG="/storage/.apps/youtube-dl/log.txt"  # location of youtube-dl log file

downloadPATH="/var/media/WD1500GB/Media/Video/.Downloads/"  # location of final destination to move downloads

touch /storage/.apps/youtube-dl/urls.txt  # optional if you want to keep a history of the urls downloaded
echo $fileURL >> /storage/.apps/youtube-dl/urls.txt

   if [ "${filename##*.}" = "m3u8" ]; then  # if filename extension downloaded by pyload is m3u8, then call youtube-dl
        rm -r $folderpath
	cd $downloadPATH
	touch $ytdl-LOG
	youtube-dl -f mp4 -o $package.mp4 $fileURL > $ytdlLOG 2>&1 &
   fi

mv -n $folderpath $downloadPATH/$package/

done


