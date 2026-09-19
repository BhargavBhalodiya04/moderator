$targetDir = "D:\Internship\AndAI\Optik\opik\apps\opik-frontend"

# Rename files and folders if they have AndAILens in the name
Rename-Item -Path "$targetDir\src\shared\InstallAndAILensSection\InstallAndAILensSection.tsx" -NewName "InstallModeratorSection.tsx" -ErrorAction SilentlyContinue
Rename-Item -Path "$targetDir\src\shared\InstallAndAILensSection" -NewName "InstallModeratorSection" -ErrorAction SilentlyContinue

# Replace "AndAI Lens" and "AndAILens" with "Moderator"
Get-ChildItem -Path "$targetDir\src" -Recurse -File -Include *.ts,*.tsx,*.html | ForEach-Object {
    $content = Get-Content -Path $_.FullName -Raw
    
    $modified = $false
    if ($content -match "AndAI Lens") {
        $content = $content -replace "AndAI Lens", "Moderator"
        $modified = $true
    }
    if ($content -match "AndAILens") {
        $content = $content -replace "AndAILens", "Moderator"
        $modified = $true
    }
    
    if ($modified) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Rebranded to Moderator in: $($_.FullName)"
    }
}

$indexHtml = "$targetDir\index.html"
if (Test-Path $indexHtml) {
    $content = Get-Content $indexHtml -Raw
    $content = $content -replace "AndAI Lens", "Moderator"
    $content = $content -replace "AndAILens", "Moderator"
    Set-Content -Path $indexHtml -Value $content -NoNewline
    Write-Host "Updated index.html to Moderator"
}
