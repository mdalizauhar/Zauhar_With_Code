Set-Location "E:\Zauhar_With_Code"

while ($true) {
    git add .

    $status = git status --porcelain

    if ($status) {
        git commit -m "Auto update $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        git push origin main
        Write-Host "Changes pushed to GitHub."
    }

    Start-Sleep -Seconds 10
}