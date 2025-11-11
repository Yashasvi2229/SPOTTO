$rebaseFile = $args[0]
$content = Get-Content $rebaseFile
$newContent = @()
$inRange = $false

foreach ($line in $content) {
    if ($line -match '^pick 60f09ac') {
        $newContent += $line -replace '^pick', 'squash'
        $inRange = $true
    } elseif ($inRange -and $line -match '^pick 5c286f1') {
        $newContent += $line -replace '^pick', 'squash'
        $inRange = $false
    } elseif ($inRange -and $line -match '^pick') {
        $newContent += $line -replace '^pick', 'squash'
    } else {
        $newContent += $line
    }
}

Set-Content $rebaseFile $newContent

