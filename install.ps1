# Launch Loop installer for Windows (PowerShell).
# Copies the skill folders from .\skills into a skills folder your assistant reads.
# It does not use the network and does not change anything else.
param(
  [switch]$Project,
  [switch]$Claude,
  [switch]$Force,
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$home_dir = [Environment]::GetFolderPath('UserProfile')

# Default: ~/.agents/skills. -Claude switches to .claude. -Project uses the current folder.
$sub = if ($Claude) { '.claude\skills' } else { '.agents\skills' }
$base = if ($Project) { (Get-Location).Path } else { $home_dir }
$target = Join-Path $base $sub

$src = Join-Path $PSScriptRoot 'skills'
if (-not (Test-Path $src)) {
  Write-Error "Cannot find the skills folder next to this script: $src"
}

Write-Host "Installing Launch Loop skills to: $target"
if ($DryRun) { Write-Host '(dry run: nothing will be copied)' }
else { New-Item -ItemType Directory -Force -Path $target | Out-Null }

$installed = 0
$skipped = 0
foreach ($dir in Get-ChildItem -Path $src -Directory -Filter 'launch-loop-*') {
  $dest = Join-Path $target $dir.Name
  if ((Test-Path $dest) -and -not $Force) {
    Write-Host "  skip    $($dir.Name) (already installed; use -Force to replace)"
    $skipped++
    continue
  }
  if ($DryRun) {
    Write-Host "  would install $($dir.Name)"
  } else {
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    Copy-Item -Recurse -Path $dir.FullName -Destination $dest
    Write-Host "  installed $($dir.Name)"
  }
  $installed++
}

Write-Host "Done: $installed installed, $skipped skipped."
Write-Host 'Restart your assistant (open a new chat or session) so it finds the skills.'
