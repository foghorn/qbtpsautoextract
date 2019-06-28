#Extract completed contents of torrent to alternate destination

#Grab the parameters passed from qBittorrent
Param([string]$srcpath='TEST')

#Specify the destination location
$destpath = 'C:\LOCATION\OF\DESTINATION'

#Output the parameters for debugging purposes
Write-Host "Extracting " + $srcpath + " to " + $destpath

#Specify the location of the WinRAR executable
$winrarloc = 'C:\Program Files\WinRAR\unrar.exe'

#Set a variable to encapsulate quotes
$quo = '"'

#Identify the path if there's a RAR file we need to extract
$rarpath = Get-ChildItem -Path $srcpath -Recurse -Include *.rar

#IF there is a RAR file found
if (-not ([string]::IsNullOrEmpty($rarpath)))
{
	#Notify the user
	Write-Host "Found file to EXTRACT: " + $rarpath
	
	#Encapsulate the RAR path so we can pass it as a command line argument to WinRAR
	$rarpath = $quo + $rarpath + $quo

	#Execute WinRAR without the text output from the process
	& $winrarloc x -ibck $rarpath $destpath
}

#If there IS NOT a RAR file specified...
else
{
	#Check the specified directory to see if there's a video file that we can copy 
	$rarpath = Get-ChildItem -Path $srcpath -Recurse -Include *.wmv, *.avi, *.mp4
	
	#If there is a video file found
	if (-not ([string]::IsNullOrEmpty($rarpath)))
	{
		#Notify the user
		Write-Host "Found file to COPY: " + $rarpath
		
		#Copy the specified file to the destination
		Copy-Item $rarpath $destpath
	}
}

#Verify that the file is correctly placed

#Get the expected file name and location
$rarpath = Split-Path $rarpath -Leaf
$checkpath = $destpath + "" + $rarpath

if (Test-Path $checkpath -PathType Leaf)
{
	#If the file is found notify the user of the successful copy
	Write-Host "File check complete for " + $checkpath
}
else
{
	#Otherwise notify the user of the failure
	Write-Host "ERROR: No file found at expected destination " + $srcpath
}

