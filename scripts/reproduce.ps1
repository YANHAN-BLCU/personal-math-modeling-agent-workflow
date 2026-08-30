param(
    [Parameter(Mandatory = $true)]
    [string]$Project,
    [string]$Command = ''
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$target = Join-Path (Join-Path $projectRoot 'projects') $Project
$manifest = Join-Path $target 'results\复现清单.json'

if (-not (Test-Path -LiteralPath $target)) { throw "项目不存在：$target" }
if (-not (Test-Path -LiteralPath $manifest)) { throw "缺少复现清单：$manifest" }

$data = Get-Content -Raw -LiteralPath $manifest | ConvertFrom-Json
$runCommand = if ($Command) { $Command } elseif ($data.reproductionCommand) { [string]$data.reproductionCommand } else { '' }
if (-not $runCommand) { throw '复现清单没有 reproductionCommand，请通过 -Command 显式提供。' }

Push-Location $target
try {
    & powershell -NoProfile -Command $runCommand
    if ($LASTEXITCODE -ne 0) { throw "复现命令失败，退出码 $LASTEXITCODE" }
} finally {
    Pop-Location
}

