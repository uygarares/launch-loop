# Launch Loop installer for Windows (PowerShell).
# Copies the skill folders from .\skills into a skills folder your assistant reads.
# It does not use the network and does not change anything else.
#
#   .\install.ps1                              -> ~\.agents\skills (Codex and most tools)
#   .\install.ps1 -ProjectPath C:\code\my-app  -> C:\code\my-app\.agents\skills
#   .\install.ps1 -Claude                      -> use .claude\skills (Claude Code); works with -ProjectPath
#   .\install.ps1 -Force                       -> replace skills that are already installed
#   .\install.ps1 -DryRun                      -> show what would happen, copy nothing
param(
  [string]$ProjectPath,
  [switch]$Project,
  [switch]$Claude,
  [switch]$Force,
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$here = $PSScriptRoot
if (-not $here) { throw 'Run this file as a script, for example: powershell -ExecutionPolicy Bypass -File .\install.ps1' }
$src = Join-Path $here 'skills'
if (-not (Test-Path $src)) { throw "Cannot find the skills folder next to this script: $src" }

$sub = if ($Claude) { '.claude\skills' } else { '.agents\skills' }

if ($ProjectPath) {
  if (-not (Test-Path $ProjectPath -PathType Container)) { throw "The project folder does not exist: $ProjectPath" }
  $base = (Resolve-Path $ProjectPath).Path
} elseif ($Project) {
  $base = (Get-Location).Path
} else {
  $base = [Environment]::GetFolderPath('UserProfile')
}
if (($ProjectPath -or $Project) -and ($base.TrimEnd('\') -eq $here.TrimEnd('\'))) {
  throw 'That is the Launch Loop folder itself, not your project. Use -ProjectPath with the path of your own project.'
}
$target = Join-Path $base $sub

$dirs = @(Get-ChildItem -Path $src -Directory -Filter 'launch-loop-*')
if ($dirs.Count -eq 0) { throw "The skills folder is empty: $src. Download Launch Loop again." }

Write-Host "Installing Launch Loop skills to: $target"
if ($DryRun) { Write-Host '(dry run: nothing will be copied)' }
else { New-Item -ItemType Directory -Force -Path $target | Out-Null }

$installed = 0
$skipped = 0
foreach ($dir in $dirs) {
  $dest = Join-Path $target $dir.Name
  if ((Test-Path $dest) -and -not $Force) {
    Write-Host "  skip    $($dir.Name) (already installed; use -Force to replace)"
    $skipped++
    continue
  }
  if ($DryRun) {
    Write-Host "  would install $($dir.Name)"
  } else {
    # Copy to a temporary folder first, so a failed copy never leaves you with nothing.
    $tmp = Join-Path $target ".$($dir.Name).installing"
    if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }
    Copy-Item -Recurse -Path $dir.FullName -Destination $tmp
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    Rename-Item -Path $tmp -NewName $dir.Name
    Write-Host "  installed $($dir.Name)"
  }
  $installed++
}

if ($DryRun) {
  Write-Host "Done: $installed would be installed, $skipped skipped."
} else {
  Write-Host "Done: $installed installed, $skipped skipped."
  Write-Host 'Restart your assistant (open a new chat or session) so it finds the skills.'
}
