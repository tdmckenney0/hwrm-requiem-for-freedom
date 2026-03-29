#Requires -Version 7.0
<#
.SYNOPSIS
    Creates a directory link at the Steam Homeworld2Classic directory named "DataTPOF"
    pointing to this repo's src directory.
    Tries a symlink first (Wine-compatible); falls back to a junction on Windows.

.PARAMETER Hw2Path
    Path to the Homeworld2Classic Steam installation directory.
    If omitted, the script resolves it from the Steam registry key.

.EXAMPLE
    ./link-src.ps1
    ./link-src.ps1 -Hw2Path "D:\Steam\steamapps\common\Homeworld\Homeworld2Classic"
#>

param(
    [string]$Hw2Path
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot  = Split-Path -Parent $ScriptDir
$SrcPath   = Join-Path $RepoRoot "src"

if (-not $Hw2Path) {
    $SteamRegKey = "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam"
    if (-not (Test-Path $SteamRegKey)) {
        $SteamRegKey = "HKLM:\SOFTWARE\Valve\Steam"
    }
    $SteamInstallPath = (Get-ItemProperty -Path $SteamRegKey -ErrorAction Stop).InstallPath
    $Hw2Path = Join-Path $SteamInstallPath "steamapps\common\Homeworld\HomeworldRM"
}

$LinkPath = Join-Path $Hw2Path "DataRFF"

if (-not (Test-Path $Hw2Path)) {
    Write-Error "HomeworldRM directory not found: $Hw2Path"
    exit 1
}

if (-not (Test-Path $SrcPath)) {
    Write-Error "Repo src directory not found: $SrcPath"
    exit 1
}

if (Test-Path $LinkPath) {
    Write-Host "Link already exists at: $LinkPath"
    exit 0
}

# Try symlink first (works under Wine; requires admin or Developer Mode on native Windows).
# Fall back to junction (native Windows only, no elevated privileges required).
try {
    $null = New-Item -ItemType SymbolicLink -Path $LinkPath -Target $SrcPath -ErrorAction Stop
    Write-Host "Created symlink: $LinkPath -> $SrcPath"
} catch {
    $null = New-Item -ItemType Junction -Path $LinkPath -Target $SrcPath
    Write-Host "Created junction: $LinkPath -> $SrcPath"
}
