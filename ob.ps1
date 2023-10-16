$search_dir = $env:BUILD_DIR
$selected=Get-ChildItem $search_dir | fzf 
if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No folder selected"
	Exit
}


$selected=$selected -replace '\s+', ' '
$selected=$selected -split ' '
$selected=$selected[3]

$targetLocation=$search_dir+"\"+$selected

$potentialGodotFile=$targetLocation+"\project.godot"
$targetIsGodot=Test-Path $potentialGodotFile -PathType leaf

if ($targetIsGodot) {
	Write-Output "Folder is godot project"
}

Set-Location -Path $targetLocation

if ($targetIsGodot) {
	#wt -w 0 new-tab -d $targetLocation godot --editor .
	nvim --listen \\.\pipe\nvim.godot.pipe .
}
