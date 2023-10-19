function Read-Prompt {
	param (
		[string]$Prompt,
		[string]$DefaultValue
	)

	$PromptValue=Read-Host -Prompt $Prompt
	if (-Not $PromptValue) {
		$PromptValue=$DefaultValue
	}

	return $PromptValue
}

function Set-TabTitle {
	param (
		[string]$Title
	)

	$Host.UI.RawUI.WindowTitle = $Title
}


Export-ModuleMember -Function Read-Prompt
Export-ModuleMember -Function Set-TabTitle
