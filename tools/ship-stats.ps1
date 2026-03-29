#!/usr/bin/env pwsh
#Requires -Version 7.0
<#
.SYNOPSIS
    Extract and compare key ship stats across all .ship files.

.DESCRIPTION
    Reads every .ship file under src/ship/ and extracts key balance-relevant
    fields. Can optionally diff against a git ref to show before/after.

.PARAMETER GitRef
    Compare current files against this git ref (e.g. "origin/master").
    When specified, outputs a diff table showing old vs new values.

.PARAMETER Ship
    Filter output to a single ship name (partial match, case-insensitive).

.PARAMETER Fields
    Comma-separated list of fields to display. Defaults to all key fields.
    Available: maxhealth, mainEngineMaxSpeed, thrusterMaxSpeed, rotationMaxSpeed,
               buildCost, buildTime, prmSensorRange, secSensorRange,
               thrusterAccelTime, thrusterBrakeTime, goalReachEpsilon, slideMoveRange

.PARAMETER Changed
    When used with -GitRef, only show ships where at least one stat changed.

.EXAMPLE
    .\tools\ship-stats.ps1
    .\tools\ship-stats.ps1 -GitRef origin/master -Changed
    .\tools\ship-stats.ps1 -GitRef origin/master -Ship battlecruiser
    .\tools\ship-stats.ps1 -Fields maxhealth,buildCost,buildTime
#>
param(
    [string]$GitRef,
    [string]$Ship,
    [string]$Fields,
    [switch]$Changed
)

Set-StrictMode -Version Latest

$RepoRoot = git rev-parse --show-toplevel 2>$null
if (-not $RepoRoot) { $RepoRoot = Split-Path $PSScriptRoot -Parent }
# Normalize to backslashes for consistent FullName comparisons on Windows
$RepoRoot = $RepoRoot.Replace('/', '\')

$KeyFields = @(
    'maxhealth',
    'mainEngineMaxSpeed',
    'thrusterMaxSpeed',
    'rotationMaxSpeed',
    'buildCost',
    'buildTime',
    'prmSensorRange',
    'secSensorRange',
    'thrusterAccelTime',
    'thrusterBrakeTime',
    'goalReachEpsilon',
    'slideMoveRange'
)

if ($Fields) {
    $KeyFields = $Fields -split ',' | ForEach-Object { $_.Trim() }
}

function Read-Stats([string]$Content) {
    $stats = [ordered]@{}
    foreach ($field in $KeyFields) {
        # Match: NewShipType.field = VALUE  (optionally followed by comment or end of line)
        if ($Content -match "(?m)^NewShipType\.$([regex]::Escape($field))\s*=\s*([0-9.]+)") {
            $stats[$field] = [double]$Matches[1]
        } else {
            $stats[$field] = $null
        }
    }
    return $stats
}

function Get-ShipStats-FromDisk([string]$ShipPath) {
    $content = Get-Content $ShipPath -Raw
    return Read-Stats $content
}

function Get-ShipStats-FromGit([string]$RelPath, [string]$Ref) {
    $gitContent = git show "${Ref}:${RelPath}" 2>$null
    if (-not $gitContent) { return $null }
    return Read-Stats ($gitContent -join "`n")
}

# Collect all ship files
$ShipDir = Join-Path $RepoRoot "src\ship"
$ShipFiles = Get-ChildItem -Path $ShipDir -Recurse -Filter "*.ship"

if ($Ship) {
    $ShipFiles = $ShipFiles | Where-Object { $_.Name -ilike "*$Ship*" }
}

$Results = [System.Collections.Generic.List[PSCustomObject]]::new()

foreach ($file in $ShipFiles | Sort-Object Name) {
    $relPath = $file.FullName.Replace($RepoRoot + "\", "").Replace("\", "/")
    $shipName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

    $current = Get-ShipStats-FromDisk $file.FullName

    if ($GitRef) {
        $old = Get-ShipStats-FromGit $relPath $GitRef
        if ($null -eq $old) {
            # New file not in ref
            $row = [ordered]@{ Ship = "$shipName (NEW)" }
            foreach ($f in $KeyFields) {
                $row["$f"] = $current[$f]
            }
            $Results.Add([PSCustomObject]$row)
            continue
        }

        $hasChange = $false
        $row = [ordered]@{ Ship = $shipName }
        foreach ($f in $KeyFields) {
            $oldVal = $old[$f]
            $newVal = $current[$f]
            if ($null -ne $oldVal -and $null -ne $newVal -and $oldVal -ne $newVal) {
                $pct = if ($oldVal -ne 0) { [math]::Round(($newVal - $oldVal) / $oldVal * 100, 1) } else { 0 }
                $sign = if ($pct -gt 0) { "+" } else { "" }
                $row[$f] = "$oldVal → $newVal ($sign$pct%)"
                $hasChange = $true
            } elseif ($null -ne $newVal) {
                $row[$f] = "$newVal"
            } else {
                $row[$f] = "—"
            }
        }

        if (-not $Changed -or $hasChange) {
            if ($hasChange) { $row['Ship'] = "* $shipName" }
            $Results.Add([PSCustomObject]$row)
        }
    } else {
        $row = [ordered]@{ Ship = $shipName }
        foreach ($f in $KeyFields) {
            $row[$f] = if ($null -ne $current[$f]) { $current[$f] } else { "—" }
        }
        $Results.Add([PSCustomObject]$row)
    }
}

if ($Results.Count -eq 0) {
    Write-Host "No ships matched." -ForegroundColor Yellow
    exit 0
}

# Output as a formatted table
$Results | Format-Table -AutoSize -Wrap
