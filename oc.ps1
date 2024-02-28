

$selected=Get-ChildItem -Directory -Recurse -Name -Depth 2 | fzf 
if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No folder selected"
	Exit
}

Set-Location -Path $selected
Set-TabTitle -Title $selected
