$ProjectPath = "E:\Zauhar_With_Code"

Set-Location $ProjectPath

Write-Host "====================================="
Write-Host " GitHub Auto Upload Started"
Write-Host " Project: $ProjectPath"
Write-Host "====================================="

$lastStatus = ""

while ($true) {

    $currentStatus = (git status --porcelain | Out-String).Trim()

    if ($currentStatus -ne $lastStatus) {

        if ($currentStatus -ne "") {

            Write-Host ""
            Write-Host "Changes detected!"
            Write-Host $currentStatus

            git add .

            $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

            git commit -m "Auto update $time"

            git push origin main

            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Host "====================================="
                Write-Host " Changes pushed to GitHub successfully!"
                Write-Host "====================================="
            }
            else {
                Write-Host "GitHub push failed."
            }
        }

        $lastStatus = $currentStatus
    }

    Start-Sleep -Seconds 2
}