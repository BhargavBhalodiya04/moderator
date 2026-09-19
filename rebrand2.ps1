$targetDir = "D:\Internship\AndAI\Optik\opik\apps\opik-frontend"

# Rename the folder and file first so we don't break the build later
Rename-Item -Path "$targetDir\src\shared\InstallPulseSection\InstallPulseSection.tsx" -NewName "InstallAndAILensSection.tsx" -ErrorAction SilentlyContinue
Rename-Item -Path "$targetDir\src\shared\InstallPulseSection" -NewName "InstallAndAILensSection" -ErrorAction SilentlyContinue

# Replace "Pulse" with "AndAI Lens"
Get-ChildItem -Path "$targetDir\src" -Recurse -File -Include *.ts,*.tsx,*.html | ForEach-Object {
    $content = Get-Content -Path $_.FullName -Raw
    
    if ($content -cmatch "Pulse") {
        $content = $content -creplace "Pulse", "AndAI Lens"
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated: $($_.FullName)"
    }
}

$indexHtml = "$targetDir\index.html"
if (Test-Path $indexHtml) {
    $content = Get-Content $indexHtml -Raw
    $content = $content -creplace "Pulse", "AndAI Lens"
    Set-Content -Path $indexHtml -Value $content -NoNewline
    Write-Host "Updated index.html"
}
