$file = "D:\Internship\AndAI\Optik\opik\deployment\docker-compose\docker-compose.yaml"
$content = Get-Content $file

$newContent = @()
$inBackend = $false
$inFrontend = $false

foreach ($line in $content) {
    if ($line -match "^  backend:" -or $line -match "^  python-backend:" -or $line -match "^  demo-data-generator:") {
        $inBackend = $true
        $inFrontend = $false
    }
    elseif ($line -match "^  frontend:") {
        $inFrontend = $true
        $inBackend = $false
    }
    elseif ($line -match "^  [a-z]") {
        $inBackend = $false
        $inFrontend = $false
    }

    if ($inBackend) {
        if ($line -match "^    build:" -or $line -match "^      context:" -or $line -match "^      dockerfile:" -or $line -match "^      args:" -or $line -match "^        OPIK_VERSION:") {
            $line = "# " + $line
        }
    }
    $newContent += $line
}

Set-Content -Path $file -Value $newContent
Write-Host "Updated docker-compose.yaml to prevent building backends"
