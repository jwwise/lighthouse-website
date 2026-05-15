$sevenZip = "C:\Program Files\7-Zip\7z.exe"
$dest     = "$PSScriptRoot\lighthouse-theme.zip"

if (Test-Path $dest) { Remove-Item $dest -Force }

& $sevenZip a -tzip $dest "$PSScriptRoot\lighthouse-theme\" | Out-Null

if ($LASTEXITCODE -ne 0) {
    Write-Error "7-Zip failed (exit $LASTEXITCODE)"
    exit 1
}

Write-Output "Built: $dest ($((Get-Item $dest).Length) bytes)"
