# 
$search_dir = $env:DEV_DIR
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
	nvim --listen \\.\pipe\nvim.godot.pipe .
}
