$selected=fzf

if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No file selected"
	Exit
}

open $selected
