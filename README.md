# MathModel Codex

面向数学建模竞赛的 Codex 原生工作流，覆盖题目理解、模型设计、代码求解、数据分析、科研制图、论文检索、Word/LaTeX 论文构建和可复现验收。

项目按需启用能力，不会在一次任务中加载全部工具。题目原件保持只读，所有新产物写入 `projects/<项目名>/`。

> 本项目生成的分析、代码、图表和论文均为学习与研究草稿。提交前必须由参赛者核对数值、公式、约束、引用和当届竞赛规则，并进行人工改写。

## 已集成能力

- 28 个数学建模 Skill，覆盖建模、编程、论文、评审、统计分析、优化和科研制图。
- 11 类常用算法：TOPSIS、线性回归、随机森林、ARIMA、逻辑回归、K-Means、PCA、线性规划、PSO、GA 和 NSGA-II。
- arXiv、Fetch、Context7、Zotero 和 GitHub 连接器。
- Word、PDF、Excel、LaTeX 文档工具。
- M1、P1、P2、W1、W2 五道独立质量门禁。
- 输入哈希、随机种子、依赖版本、参数和复现命令记录。

飞书、微信和 MathModel 专用浏览器桥接不在本项目范围内。

## 运行要求

- Windows 10/11 与 PowerShell。
- Codex Desktop 或 Codex CLI。
- Python 3.12。
- [`uv`](https://docs.astral.sh/uv/)；仅首次创建环境或重装依赖时需要。

当前连接器配置使用 `F:\数模` 下的本地可执行文件。保持该项目路径可直接使用；放到其他目录时，需要同步调整 `plugins/mathmodel-codex/.mcp.json` 中的路径。

## 首次安装

```powershell
git clone https://github.com/YANHAN-BLCU/personal-math-modeling-agent-workflow.git F:\数模
Set-Location F:\数模

.\scripts\install_algorithms.ps1
.\scripts\install_connectors.ps1
.\scripts\doctor.ps1
```

在 Codex 中打开 `F:\数模`。项目市场配置会将 `mathmodel-codex@mathmodel-project` 作为默认插件；可用以下命令检查：

```powershell
codex plugin list
```

如插件没有自动安装，可手动执行：

```powershell
codex plugin add mathmodel-codex@mathmodel-project
```

## 日常使用

### 方式一：直接交给 Codex

把题目 PDF、Word、Excel、图片及其他附件放入 `problems/`，或直接在 Codex 对话中上传，然后发送：

```text
请完成这道数学建模题，执行完整流程。题目和附件位于 problems/2026-CUMCM-A。
目标竞赛为 2026 年全国大学生数学建模竞赛，默认生成中文 Word 论文。
```

没有指定阶段时，默认执行建模、编程、科研制图、论文和最终验收的完整流程。能够从题目或附件确定的信息不会重复询问。

常用请求示例：

```text
只分析题目并设计模型，暂时不要写代码。
```

```text
根据现有建模报告完成代码求解、结果表和科研制图。
```

```text
根据真实运行结果生成完整 Word 论文，并执行 W1、W2 质检。
```

```text
评审 projects/2026-CUMCM-A/完整论文.docx，按竞赛评委标准指出问题。
```

### 方式二：先建立项目目录

```powershell
.\scripts\init_project.ps1 `
  -Name "2026-CUMCM-A" `
  -ProblemSource "F:\数模\problems\2026-CUMCM-A"
```

生成的目录如下：

```text
projects/2026-CUMCM-A/
├─ inputs/                 输入副本或转换材料
├─ src/                    模型与求解代码
├─ results/                表格、指标和复现清单
├─ figures/                候选图与正式图
├─ paper/                  论文构建材料
└─ README.md               竞赛信息与阶段状态
```

## 标准工作流

1. 盘点题目和附件，核验竞赛名称、届次、语言、官方规则与模板。
2. 拆解子问题，完成数据剖析、文献检索、模型选择和假设设计。
3. 生成 `题目分析报告.md` 和 `术语表格.md`，并通过 `M1` 建模质检。
4. 编写并真实运行 Python 或 MATLAB 代码；`P1` 先验证最小可运行结果。
5. 完成全量计算、参数扫描、结果表和科研图，通过 `P2` 编程质检。
6. 建立主张、公式、结果、图表和文献的证据映射，通过 `W1` 后写论文。
7. 默认生成 `完整论文.docx`；明确要求时同时生成 LaTeX 源码和 PDF。
8. 通过 `W2` 论文终检，再执行复现和项目验收。

论文默认采用“问题重述、问题分析、模型假设、符号说明、模型准备、各问题模型建立及求解、灵敏度分析、模型评价与推广”的正文框架。正文以约 15000 个中文字符、约 20 页为常规质量目标；官方模板、页数限制和内容质量始终优先。

## 检查与复现

检查环境：

```powershell
.\scripts\doctor.ps1
```

检查项目结构、插件、Skill、算法和连接器：

```powershell
.\scripts\validate.ps1
```

检查某个题目的基本交付结构：

```powershell
.\scripts\validate.ps1 -Project "2026-CUMCM-A"
```

按 `results/复现清单.json` 重新运行题目：

```powershell
.\scripts\reproduce.ps1 -Project "2026-CUMCM-A"
```

需要显式覆盖复现命令时：

```powershell
.\scripts\reproduce.ps1 `
  -Project "2026-CUMCM-A" `
  -Command "..\..\.venv\Scripts\python.exe src\main.py"
```

## 目录说明

```text
F:\数模
├─ AGENTS.md                       Codex 项目规则与能力路由
├─ config/                         能力、算法、模型和质量门禁配置
├─ plugins/mathmodel-codex/        项目插件及数学建模 Skills
├─ problems/                       题目与原始附件，只读使用
├─ projects/                       每道题的权威工作目录
├─ knowledge/                      优秀论文和可检索参考资料
├─ templates/                      论文、结果和图表模板
├─ scripts/                        安装、初始化、诊断、复现和校验脚本
├─ .venv/                          项目隔离 Python 环境
└─ .tools/                         本地连接器运行环境
```

能力清单以 `config/capabilities.json` 为准，算法目录以 `config/algorithms.json` 为准，阶段门禁以 `config/quality-gates.yaml` 为准。

## 安全与边界

- 不要把 API Key、Cookie、Token 或桌面认证缓存提交到仓库。
- 外部服务凭据只通过环境变量或 Codex 安全配置提供。
- 不修改原始题目和附件；格式转换结果写入对应项目目录。
- 所有数值结论必须来自真实代码输出，引用必须能够追溯到原始来源。
- 本项目不承诺竞赛奖项，也不能替代参赛者的独立判断和最终审核。
