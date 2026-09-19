$targetDir = "D:\Internship\AndAI\Optik\opik\apps\opik-frontend"

Get-ChildItem -Path "$targetDir\src" -Recurse -File -Include *.ts,*.tsx | ForEach-Object {
    $content = Get-Content -Path $_.FullName -Raw
    
    # This regex looks for "AndAI Lens" immediately followed by a letter (like "AndAI LensEvent")
    # and replaces it with "AndAILens" so that variables/components don't have spaces!
    if ($content -match "AndAI Lens(?=[A-Za-z])") {
        $content = $content -replace "AndAI Lens(?=[A-Za-z])", "AndAILens"
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Fixed syntax in: $($_.FullName)"
    }
}
