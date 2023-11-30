Import-Module $PSScriptRoot\UtilsModule.psm1

# Deactivate python venv
if (Test-Path env:VIRTUAL_ENV) {
	deactivate
}

$search_dir = $env:DEV_DIR
$selected=Get-ChildItem -Path $search_dir -Directory -Recurse -Name -Depth 2 | fzf 
if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No folder selected"
	Exit
}

# $selected=$selected -replace '\s+', ' '
# $selected=$selected -split ' '
# $selected=$selected[3]

$TargetLocation=$search_dir+"\"+$selected

Set-Location -Path $TargetLocation

$PotentialGodotFile="\project.godot"

$TargetIsGodot=Test-Path $potentialGodotFile -PathType leaf
if ($TargetIsGodot) {
	Write-Output "Detected godot.project file"
}

$TargetIsPython=Test-Path "requirements.txt" -PathType leaf
$TargetHasVenv=Test-Path "venv" -PathType container
$MakeVenv=$false
$SourceVenv=$true
if ($TargetIsPython -And -Not $TargetHasVenv) {
	Write-Output "Detected requirements.txt file but not venv"
	$MakeVenvResponse=Read-Prompt -Prompt "Make venv (default yes)" -DefaultValue "yes"
	if ($MakeVenvResponse -And $MakeVenvResponse.Substring(0,1) -eq "y") {
		$MakeVenv=$true
	} else {
		$SourceVenv=$false
	}
}


Set-TabTitle -Title $selected


if ($TargetIsPython -And $MakeVenv) {
	Write-Output "Making venv"
	mkdir venv
	cd venv
	python -m venv .
	cd ..
	Write-Output "Installing requiremnts"
	.\venv\Scripts\activate
	pip install -r requirements.txt
}

if ($TargetIsPython -And $SourceVenv) {
	.\venv\Scripts\activate
}


