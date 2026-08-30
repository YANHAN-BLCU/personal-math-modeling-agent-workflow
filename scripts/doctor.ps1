$ErrorActionPreference = 'Continue'
$projectRoot = Split-Path -Parent $PSScriptRoot
$capabilitiesPath = Join-Path $projectRoot 'config\capabilities.json'
$algorithmPath = Join-Path $projectRoot 'config\algorithms.json'
$skillRoot = Join-Path $projectRoot 'plugins\mathmodel-codex\skills'
$python = Join-Path $projectRoot '.venv\Scripts\python.exe'
$plugin = Join-Path $projectRoot 'plugins\mathmodel-codex\.codex-plugin\plugin.json'

$checks = [System.Collections.Generic.List[object]]::new()
function Add-Check([string]$Name, [bool]$Ok, [string]$Detail) {
    $checks.Add([pscustomobject]@{ Name = $Name; Status = $(if ($Ok) { 'PASS' } else { 'FAIL' }); Detail = $Detail })
}

Add-Check 'AGENTS.md' (Test-Path -LiteralPath (Join-Path $projectRoot 'AGENTS.md')) '项目入口'
Add-Check '能力注册表' (Test-Path -LiteralPath $capabilitiesPath) $capabilitiesPath
Add-Check '算法目录' (Test-Path -LiteralPath $algorithmPath) $algorithmPath
Add-Check '来源锁定清单' (Test-Path -LiteralPath (Join-Path $projectRoot 'config\sources.json')) 'config/sources.json'
Add-Check '插件清单' (Test-Path -LiteralPath $plugin) $plugin
Add-Check 'Python 隔离环境' (Test-Path -LiteralPath $python) $python
foreach ($tool in @('arxiv-mcp-server.exe', 'mcp-server-fetch.exe', 'zotero-mcp.exe')) {
    $toolPath = Join-Path $projectRoot ".tools\bin\$tool"
    Add-Check "Connector:$tool" (Test-Path -LiteralPath $toolPath) $toolPath
}

if (Test-Path -LiteralPath $capabilitiesPath) {
    $capabilities = Get-Content -Raw -LiteralPath $capabilitiesPath | ConvertFrom-Json
    $expectedSkills = @($capabilities.skills.bundled) + @($capabilities.skills.recommended)
    foreach ($skill in $expectedSkills) {
        $skillFile = Join-Path (Join-Path $skillRoot $skill) 'SKILL.md'
        Add-Check "Skill:$skill" (Test-Path -LiteralPath $skillFile) $skillFile
    }
    $excludedText = $capabilities.excluded -join ','
    $excludedOk = @('feishu','wechat','mathmodel-browser-bridge') | ForEach-Object { $excludedText -match [regex]::Escape($_) } | Where-Object { -not $_ } | Measure-Object | Select-Object -ExpandProperty Count
    Add-Check '排除连接器策略' ($excludedOk -eq 0) $excludedText
}

if (Test-Path -LiteralPath $python) {
    & $python -c "import pymcdm, sklearn, statsmodels, scipy, mealpy, pymoo; print('algorithm imports ok')" 2>$null
    Add-Check '算法包导入' ($LASTEXITCODE -eq 0) 'pymcdm, sklearn, statsmodels, scipy, mealpy, pymoo'
}

$checks | Format-Table -AutoSize
$failed = @($checks | Where-Object Status -eq 'FAIL')
if ($failed.Count -gt 0) {
    Write-Error "环境诊断发现 $($failed.Count) 个失败项。"
    exit 1
}
Write-Output "环境诊断通过：$($checks.Count) 项。"
