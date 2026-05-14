Add-Type -Assembly System.IO.Compression.FileSystem
Add-Type -Assembly System.IO.Compression

$dest = "$PSScriptRoot\lighthouse-theme.zip"
if (Test-Path $dest) { Remove-Item $dest -Force }
$themeRoot = "$PSScriptRoot\lighthouse-theme"
$stream = [System.IO.File]::Open($dest, [System.IO.FileMode]::Create)
$archive = New-Object System.IO.Compression.ZipArchive($stream, [System.IO.Compression.ZipArchiveMode]::Create)

Get-ChildItem $themeRoot -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($themeRoot.Length + 1).Replace('\', '/')
    $entry = $archive.CreateEntry("lighthouse-theme/$rel", [System.IO.Compression.CompressionLevel]::Optimal)
    $es = $entry.Open(); $fs = [System.IO.File]::OpenRead($_.FullName)
    $fs.CopyTo($es); $fs.Close(); $es.Close()
}

$archive.Dispose()
$stream.Close()
Write-Output "Built: $dest ($((Get-Item $dest).Length) bytes)"
