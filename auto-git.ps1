$ProjectPath = "E:\Zauhar_With_Code"

Set-Location $ProjectPath

Write-Host "====================================="
Write-Host "   GitHub Auto Upload Started"
Write-Host "====================================="
Write-Host "Project: $ProjectPath"
Write-Host "Watching for file changes..."
Write-Host ""

# File watcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $ProjectPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Ignore Git internal files
$watcher.Filter = "*.*"

$action = {

    Start-Sleep -Milliseconds 1000

    Set-Location $ProjectPath

    $changes = git status --porcelain

    if ($changes) {

        Write-Host ""
        Write-Host "Changes detected..."

        git add .

        $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $commitMessage = "Auto update - $date"

        git commit -m "$commitMessage"

        if ($LASTEXITCODE -eq 0) {

            Write-Host "Commit created successfully."

            git push origin main

            if ($LASTEXITCODE -eq 0) {
                Write-Host "Successfully pushed to GitHub."
            }
            else {
                Write-Host "Push failed."
            }
        }
    }
}

Register-ObjectEvent `
    -InputObject $watcher `
    -EventName Changed `
    -Action $action | Out-Null

Register-ObjectEvent `
    -InputObject $watcher `
    -EventName Created `
    -Action $action | Out-Null

Register-ObjectEvent `
    -InputObject $watcher `
    -EventName Renamed `
    -Action $action | Out-Null

while ($true) {
    Start-Sleep -Seconds 1
}