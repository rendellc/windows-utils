$search_dir = $env:DEV_DIR
$selected=Get-ChildItem $search_dir | fzf 
$selected=$selected -replace '\s+', ' '
$selected=$selected -split ' '
$selected=$selected[3]

Set-Location -Path $search_dir\$selected

