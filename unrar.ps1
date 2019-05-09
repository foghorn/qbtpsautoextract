#Extract completed contents of torrent to alternate destination

Param([string]$srcpath='TEST')

#Specify the destination location
$destpath = 'C:\LOCATION\OF\DESTINATION'

Write-Host "Extracting " + $srcpath + " to " + $destpath

$winrarloc = 'C:\Program Files\WinRAR\unrar.exe'

$quo = '"'

$rarpath = Get-ChildItem -Path $srcpath -Recurse -Include *.rar

if (-not ([string]::IsNullOrEmpty($rarpath)))
{
	Write-Host "Found file to EXTRACT: " + $rarpath
	$rarpath = $quo + $rarpath + $quo
	& $winrarloc x -ibck $rarpath $destpath
}
else
{
	$rarpath = Get-ChildItem -Path $srcpath -Recurse -Include *.wmv, *.avi, *.mp4
	
	if (-not ([string]::IsNullOrEmpty($rarpath)))
	{
		Write-Host "Found file to COPY: " + $rarpath
		Copy-Item $rarpath $destpath
	}
}
