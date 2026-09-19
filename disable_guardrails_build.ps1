$file = "D:\Internship\AndAI\Optik\opik\deployment\docker-compose\docker-compose.yaml"
$content = Get-Content $file

$newContent = @()
$inGuardrails = $false

foreach ($line in $content) {
    if ($line -match "^  guardrails-backend:" -or $line -match "^  guardrails-backend-cpu:") {
        $inGuardrails = $true
    }
    elseif ($line -match "^  [a-z]") {
        $inGuardrails = $false
    }

    if ($inGuardrails) {
        if ($line -match "^    build:" -or $line -match "^      context:" -or $line -match "^      dockerfile:") {
            $line = "# " + $line
        }
    }
    $newContent += $line
}

Set-Content -Path $file -Value $newContent
Write-Host "Disabled building for guardrails"
