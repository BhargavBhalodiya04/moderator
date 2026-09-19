$targetDir = "D:\Internship\AndAI\Optik\opik\apps\opik-frontend"

# We selectively replace "Opik" with "Pulse" (Case Sensitive) to avoid breaking the backend API!
Get-ChildItem -Path "$targetDir\src" -Recurse -File -Include *.ts,*.tsx,*.html | ForEach-Object {
    $content = Get-Content -Path $_.FullName -Raw
    
    # -csplit and -cjoin for Case-Sensitive replacement
    if ($content -cmatch "Opik") {
        $content = $content -creplace "Opik", "Pulse"
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated: $($_.FullName)"
    }
}

# Also update the main index.html title
$indexHtml = "$targetDir\index.html"
if (Test-Path $indexHtml) {
    $content = Get-Content $indexHtml -Raw
    $content = $content -creplace "Opik", "Pulse"
    Set-Content -Path $indexHtml -Value $content -NoNewline
    Write-Host "Updated index.html"
}
