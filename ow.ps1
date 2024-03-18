# Example usage:
# Get-ChildItem -Recurse | Select-Object -ExpandProperty FullName | Continous-Search

$selected=Get-ChildItem -Directory -Recurse -Name | fzf 
if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No folder selected"
	Exit
}

Set-Location -Path $selected
