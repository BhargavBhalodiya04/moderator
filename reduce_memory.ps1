$file = "D:\Internship\AndAI\Optik\opik\apps\opik-frontend\vite.config.ts"
$content = Get-Content $file -Raw

$content = $content -replace "sourcemap: true", "sourcemap: false, minify: false"
Set-Content -Path $file -Value $content -NoNewline
Write-Host "Disabled sourcemaps and minification in vite.config.ts to save memory"
