$ProjectPath = "E:\Zauhar_With_Code"

Set-Location $ProjectPath

Write-Host "====================================="
Write-Host "      GitHub Auto Upload Started"
Write-Host "====================================="
Write-Host "Project: $ProjectPath"
Write-Host "Checking every 2 seconds..."
Write-Host ""

while ($true) {

    $changes = git status --porcelain

    if ($changes) {

        Write-Host ""
        Write-Host "Changes detected!"
        Write-Host $changes

        git add .

        $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $commitMessage = "Auto update - $date"

        git commit -m "$commitMessage"

        if ($LASTEXITCODE -eq 0) {

            Write-Host "Commit created successfully."

            git push origin main

            if ($LASTEXITCODE -eq 0) {
                Write-Host "Successfully pushed to GitHub!"
            }
            else {
                Write-Host "ERROR: Push failed."
            }
        }
    }

    Start-Sleep -Seconds 2
}