param([switch]$Upgrade)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$venv = Join-Path $projectRoot '.venv'
$python = Join-Path $venv 'Scripts\python.exe'
$requirements = Join-Path $projectRoot 'config\requirements-algorithms.txt'
$uvCandidates = @(
    (Get-Command uv -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue),
    'C:\Users\17009\AppData\Local\Programs\@mathmodeldesktop\resources\bin\uv.exe'
) | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -Unique

if (-not $uvCandidates) {
    throw '未找到 uv。请先安装 uv，再重新运行。'
}
$uv = $uvCandidates[0]

if (-not (Test-Path -LiteralPath $python)) {
    & $uv venv $venv --python 3.12
    if ($LASTEXITCODE -ne 0) { throw "创建虚拟环境失败，退出码 $LASTEXITCODE" }
}

$arguments = @('pip', 'install', '--python', $python, '-r', $requirements)
if ($Upgrade) { $arguments += '--upgrade' }
& $uv @arguments
if ($LASTEXITCODE -ne 0) { throw "算法依赖安装失败，退出码 $LASTEXITCODE" }

