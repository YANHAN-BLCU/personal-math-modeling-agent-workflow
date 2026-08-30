param([string]$Project = '')

$ErrorActionPreference = 'Continue'
$env:PYTHONUTF8 = '1'
$projectRoot = Split-Path -Parent $PSScriptRoot
& (Join-Path $PSScriptRoot 'doctor.ps1')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$pluginValidator = 'C:\Users\17009\.codex\skills\.system\plugin-creator\scripts\validate_plugin.py'
$pluginRoot = Join-Path $projectRoot 'plugins\mathmodel-codex'
if (Test-Path -LiteralPath $pluginValidator) {
    python $pluginValidator $pluginRoot
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

$migrationValidator = 'C:\Users\17009\.codex\skills\migrate-to-codex\scripts\migrate-to-codex.py'
python $migrationValidator --validate-target (Join-Path $projectRoot '.codex')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

if ($Project) {
    $target = Join-Path (Join-Path $projectRoot 'projects') $Project
    if (-not (Test-Path -LiteralPath $target)) { throw "项目不存在：$target" }
    foreach ($required in @('README.md', 'results', 'figures')) {
        if (-not (Test-Path -LiteralPath (Join-Path $target $required))) {
            Write-Error "项目缺少：$required"
            exit 1
        }
    }
}
Write-Output '项目结构与能力注册表校验通过。'
