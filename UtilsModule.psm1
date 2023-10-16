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

Export-ModuleMember -Function Read-Prompt
