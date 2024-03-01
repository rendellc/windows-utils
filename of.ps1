$selected=fzf

if ([string]::IsNullOrEmpty($selected)) {
	Write-Host "No file selected"
	Exit
}

$textExtensions = @(".txt", ".md", ".lua", ".cpp", ".c", ".h", ".cs", ".java", ".py", ".html", ".css", ".js", ".json", ".xml")

$selectedExtension=[System.IO.Path]::GetExtension($selected)

if ($textExtensions -contains $selectedExtension.ToLower()) {
	nvim $selected
	# Start-Process nvim -ArgumentList $selected -Wait
} else {
	open $selected
}
