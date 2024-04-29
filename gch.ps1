$selected_branch = (git branch -a | ForEach-Object { $_.Trim() } | fzf).Trim()
if ($selected_branch.StartsWith("remotes/origin/"))
{
    $feature_name = $selected_branch.Substring("remotes/origin/".Length).Trim()
} else
{
    $feature_name = $selected_branch.Trim()
}

git checkout $feature_name
