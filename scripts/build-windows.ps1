$ErrorActionPreference = 'Stop'

$projectDir = Split-Path -Parent $PSScriptRoot
$output = Join-Path $projectDir 'build\test-game.pdx'
$sdkPath = $env:PLAYDATE_SDK_PATH

if ([string]::IsNullOrWhiteSpace($sdkPath)) {
    throw 'PLAYDATE_SDK_PATH is not set. Set it to your Playdate SDK folder, for example: C:\Users\<name>\Documents\PlaydateSDK'
}

$pdc = Join-Path $sdkPath 'bin\pdc.exe'
$simulator = Join-Path $sdkPath 'bin\PlaydateSimulator.exe'
$source = Join-Path $projectDir 'source'

if (-not (Test-Path -LiteralPath $pdc -PathType Leaf)) {
    throw "Playdate compiler not found: $pdc"
}
if (-not (Test-Path -LiteralPath $simulator -PathType Leaf)) {
    throw "Playdate Simulator not found: $simulator"
}
if (-not (Test-Path -LiteralPath $source -PathType Container)) {
    throw "Project source folder not found: $source"
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $output) | Out-Null
& $pdc $source $output
if ($LASTEXITCODE -ne 0) {
    throw "Build failed with exit code $LASTEXITCODE"
}

Write-Host 'Build completata:'
Write-Host $output
[string]$outputArgumentPattern = '(?:^|\s|")' + [regex]::Escape($output) + '(?:$|\s|")'
[Microsoft.Management.Infrastructure.CimInstance]$runningSimulator = Get-CimInstance Win32_Process -Filter "Name = 'PlaydateSimulator.exe'" |
    Where-Object { $_.ExecutablePath -eq $simulator -and $_.CommandLine -match $outputArgumentPattern } |
    Sort-Object CreationDate -Descending |
    Select-Object -First 1

if ($null -ne $runningSimulator) {
    # Ctrl+R reloads the rebuilt game in the existing Simulator window.
    [object]$shell = New-Object -ComObject WScript.Shell
    if (-not $shell.AppActivate([int]$runningSimulator.ProcessId)) {
        throw 'Cannot activate the running Playdate Simulator. Close it and run the build again.'
    }
    $shell.SendKeys('^r')
    Write-Host 'Gioco ricaricato nel simulatore aperto.'
} else {
    Start-Process -FilePath $simulator -ArgumentList ('"{0}"' -f $output) -WindowStyle Normal
    Write-Host 'Simulatore avviato.'
}
