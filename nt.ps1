# Open a new tab in the current windows terminal in the current directory

$currentDirectory=Get-Location
wt -w 0 new-tab -d $currentDirectory
