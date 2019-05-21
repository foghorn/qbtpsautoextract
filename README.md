# qbtpsautoextract

PowerShell script to automatically extract contents of a RAR archive upon completion of a torrent

## Overview

This project is intended to be used to automatically extract the RAR archived contents of a completed torrent file (containing perfectly legal and legitimate content ONLY) to a second or remote destination.

In the event that the script does not find a valid RAR archive it can also copy files of a specified file extension. By default the file copies video files but can be edited to include others as well.

The script assumes that:
* You have WinRAR installed on your system (you can specify an alternate installation location if needed)
* You are using qBittorrent client
* You are using a Windows system that has PowerShell installed
* You are passing the script a file location that does not include any spaces

## Getting Started
1. Download the script locally on the system

2. Edit the script to point to your desired destination folder

Open the script in a text edior. 

Look for this line:

```
$destpath = "C:\LOCATION\OF\DESTINATION"
```

Replace the listed path with your desired destination folder.

3. Enable the system to run unsigned PowerShell scripts

Search for "PowerShell" in your start menu. 

Right click and select "Run as Administrator"

Enter the following command: 
```
set-executionpolicy remotesigned
```

4. Ensure that WinRAR is installed.

If you have installed it in a location other than C:\Program Files\WinRAR\ you will need to edit the location in the script.  

5. Configure qBittorrent to run the script after each download completes

Tools -> Options -> Downloads

Select "Run external program on torrent completion"

Enter the following in the box, updating with your correct path:

```
powershell C:\[PATH-TO-SCRIPT]\unrar.ps1 -srcpath "%F" 
```

6. Enjoy!

## Troubleshooting
### Using a NAS or network share as a destination
If you're using a NAS as your destination (such as a Synology device) and have mapped the share to a drive letter on your system the script may sometimes not work, especially if you are not in the same subnet as the share.

Solution: Don't use the drive letter, instead use the absolute network location (eg. //SERVER.DOMAIN/SHARE/FOLDER)
