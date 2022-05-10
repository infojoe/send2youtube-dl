# send2youtube-dl
Pyload download manager script to redirect HLS / m3u8 urls to youtube-dl

I enjoy using an old Rasberry Pi2 running LIBREELEC as an external downloader for online videos. For non HLS type videos, I have been using aria2c along with a great android app called Aria2app. Unfortunately aria2c fails to download HLS based m3u8 files so I needed to find a way to send these files over to youtube-dl which works perfectly to download these sliced up videos. 

There is a limitation with aria2c though as it does not pass the original URI as an argument to the "--on-download-complete=" script. Also, there seems to be no easy way to setup a youtube-dl web interface directly on LIBREELEC without resorting to using docker. Therefore I decided to give pyload a try and found that it works perfectly for me. It has a great web interface and companion android app as well as firefox and chrome extensions. Upon downloading an m3u8/hls file, it is able to call a script on completion and passes more arguments than aria2c including the original URI.

Therefore, I have created a rudimentary bash script that works with pyload and youtube-dl on a pi2 running LIBREELEC. In the future, I hope that aria2c will include the same ability to pass the URI to external scripts and the script should be able to be easily adapted for aria2c as well.

The script requires pyload to be installed which in my case was installed as a kodi addon (service.downloadmanager.pyload-6.0.6-RPi2.zip). It also relies on youtube-dl to be installed either as a kodi addon or to a writeable location (in my case "/storage/.apps"), as well as ffmpeg (install from LIBREELEC repo). To obtain the links to m3u8 video, I am using a firefox extension called "The Stream Detector" on PC, and an app called "Web Media Share" on android.

The basic function of the script is to check if the file downloaded has the ".m3u8" extension and if so call youtube-dl to retry the download link. If the file is not an m3u8, it simply moves the entire package folder to your specified final destination folder. Please feel free to improve on my work and share any improvements.
