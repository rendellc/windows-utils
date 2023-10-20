Import-Module $PSScriptRoot\UtilsModule.psm1

# Deactivate python venv
if (Test-Path env:VIRTUAL_ENV) {
	deactivate
}

$search_dir = $env:DEV_DIR
$selected=Get-ChildItem $search_dir | fzf 
if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No folder selected"
	Exit
}


$selected=$selected -replace '\s+', ' '
$selected=$selected -split ' '
$selected=$selected[3]

$TargetLocation=$search_dir+"\"+$selected

$PotentialGodotFile=$TargetLocation+"\project.godot"

$TargetIsGodot=Test-Path $potentialGodotFile -PathType leaf
if ($TargetIsGodot) {
	Write-Output "Detected godot.project file"
}

$PotentialPythonFile=$TargetLocation+"\requirements.txt"
$TargetIsPython=Test-Path $PotentialPythonFile -PathType leaf
if ($TargetIsPython) {
	$SourceVenv=$false
	Write-Output "Detected requirements.txt file"
	$SourceVenvResponse=Read-Prompt -Prompt "Source venv (default yes)" -DefaultValue "yes"
	if ($SourceVenvResponse -And $SourceVenvResponse.Substring(0,1) -eq "y") {
		$SourceVenv=$true
	}
}

$OpenEditor=$false
$OpenEditorResponse=Read-Prompt -Prompt "Open editor (default no)" -DefaultValue "no"
if ($OpenEditorResponse -And $OpenEditorResponse.Substring(0,1) -eq "y") {
	$OpenEditor=$true
}

$OpenGodot=$false
if ($TargetIsGodot) {
	$OpenGodotResponse=Read-Prompt -Prompt "Open godot (default no)" -DefaultValue "no"
	if ($OpenGodotResponse -And $OpenGodotResponse.Substring(0,1) -eq "y") {
		$OpenGodot=$true
	}
}

Set-Location -Path $targetLocation
Set-TabTitle -Title $selected

if ($TargetIsGodot) {
	if ($OpenEditor) {
		nvim --listen \\.\pipe\nvim.godot.pipe .
	}
	if ($OpenGodot) {
		wt -w 0 new-tab -d $targetLocation godot --editor .
	}
}

if ($OpenEditor) {
	nvim .
}

if ($TargetIsPython -And $SourceVenv) {
	.\venv\Scripts\activate
}


