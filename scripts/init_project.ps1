param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[^\\/:*?"<>|]+$')]
    [string]$Name,
    [string]$ProblemSource = ''
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$projectsRoot = Join-Path $projectRoot 'projects'
$target = Join-Path $projectsRoot $Name

if (Test-Path -LiteralPath $target) {
    throw "项目已存在：$target"
}

New-Item -ItemType Directory -Path $target | Out-Null
foreach ($directory in @('inputs', 'src', 'results', 'figures', 'paper')) {
    New-Item -ItemType Directory -Path (Join-Path $target $directory) | Out-Null
}

if ($ProblemSource) {
    $resolvedSource = (Resolve-Path -LiteralPath $ProblemSource).Path
    Set-Content -LiteralPath (Join-Path $target 'problem-source.txt') -Value $resolvedSource -Encoding UTF8
}

$readme = @"
# $Name

- 竞赛：待填写
- 届次：待填写
- 官方规则：待核验
- 题目来源：见 problem-source.txt 或 inputs/

## 阶段状态

- [ ] M1 建模终检
- [ ] P1 最小可运行结果
- [ ] P2 编程终检
- [ ] W1 证据大纲
- [ ] W2 论文终检
"@
Set-Content -LiteralPath (Join-Path $target 'README.md') -Value $readme -Encoding UTF8
Write-Output $target

