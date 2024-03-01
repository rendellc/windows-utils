

$selected=Get-ChildItem -Directory -Recurse -Name | fzf 
if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No folder selected"
	Exit
}

Set-Location -Path $selected
