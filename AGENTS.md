# MathModel Codex 项目

本项目把数学建模能力作为 Codex 原生工作流运行。所有新产物必须写入当前题目的 `projects/<项目名>/`，题目原件和附件保持只读。

## 默认语言

- 使用中文交流与交付；目标竞赛要求英文时再切换英文论文流程。
- 论文、分析、代码结果均为学习与研究草稿，提交前必须人工核对与改写。

## 能力入口

- 完整建模、题目分析、编程求解、科研制图或论文生成：优先使用 `math-modeling`。
- 环境诊断：使用 `doctor`，或运行 `scripts/doctor.ps1`。
- 内置科研图模板：使用 `mathmodel-figure-templates`。
- 数据图、技术路线图和流程图：先使用 `mma-figure` 路由。
- 论文检索：使用 `paper-search`；引用必须可追溯。
- 论文构建与评审：使用 `mma-paper`、`mma-review`，并服从 `math-modeling` 的阶段门禁。
- 算法选型以 `config/algorithms.json` 为目录；代码必须在项目 `.venv` 中实际运行。
- 其他已安装能力以 `config/capabilities.json` 为准，按任务触发，不要一次性加载所有 Skill。

## 标准流程

1. 在 `projects/` 下为每道题建立独立目录，或运行 `scripts/init_project.ps1 -Name <名称>`。
2. 核验目标竞赛、届次、官方规则和模板；未核验时明确标记待核验。
3. 按 `math-modeling` 的建模手、编程手、论文手三阶段执行。
4. 固定运行 M1、P1、P2、W1、W2 独立质检门禁；失败必须返工并复验。
5. 数值结论必须来自真实代码输出；图表、公式、表格和论文必须共享同一证据源。
6. 交付前运行 `scripts/reproduce.ps1` 和 `scripts/validate.ps1`。

## 目录合同

- `problems/`：题目与附件的只读入口。
- `projects/`：每道题的权威工作目录。
- `knowledge/`：优秀论文和检索资料，仅作参考证据。
- `templates/`：论文、结果和图表模板。
- `config/`：项目、模型、质量门禁和能力注册表。
- `plugins/mathmodel-codex/`：项目 Codex 插件及全部数学建模 Skills。
- `.venv/`：项目隔离 Python 环境。

## 排除项

不要安装、配置或调用飞书、微信、MathModel 专用浏览器桥接。通用网页检索、GitHub、Context7、arXiv、Zotero 和标准 MCP 不在排除范围内。

## 安全与可复现

- 不把 API Key、Cookie、Token 或桌面端认证缓存复制进项目。
- 外部连接器凭据只能通过环境变量或 Codex 安全配置提供。
- 不修改输入附件；需要转换时写入当前项目目录。
- 保留随机种子、输入 SHA-256、依赖版本、参数和唯一复现命令。
