$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$uv = Join-Path $projectRoot '.venv\Scripts\uv.exe'
$python = Join-Path $projectRoot '.venv\Scripts\python.exe'
$toolDir = Join-Path $projectRoot '.tools\uv'
$binDir = Join-Path $projectRoot '.tools\bin'

if (-not (Test-Path -LiteralPath $uv)) {
    & (Join-Path $PSScriptRoot 'install_algorithms.ps1')
}
if (-not (Test-Path -LiteralPath $uv)) { throw "未找到项目 uv：$uv" }

$env:UV_TOOL_DIR = $toolDir
$env:UV_TOOL_BIN_DIR = $binDir
New-Item -ItemType Directory -Force -Path $toolDir, $binDir | Out-Null

foreach ($package in @('arxiv-mcp-server==0.7.2', 'mcp-server-fetch==2026.8.18', 'zotero-mcp==0.3.1')) {
    & $uv tool install $package --python $python --force
    if ($LASTEXITCODE -ne 0) { throw "Connector 安装失败：$package，退出码 $LASTEXITCODE" }
}

Write-Output "Connector 可执行文件已安装到 $binDir"
