$ProjectPath = "E:\Zauhar_With_Code"

Set-Location $ProjectPath

Write-Host "====================================="
Write-Host " GitHub Auto Upload Started"
Write-Host " Project: $ProjectPath"
Write-Host "====================================="

while ($true) {

    $changes = git status --porcelain

    if ($changes) {

        Write-Host ""
        Write-Host "Changes detected..."

        git add .

        $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        git commit -m "Auto update $time"

        git push origin main

        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully uploaded to GitHub."
        }
        else {
            Write-Host "GitHub push failed."
        }
    }

    Start-Sleep -Seconds 5
}