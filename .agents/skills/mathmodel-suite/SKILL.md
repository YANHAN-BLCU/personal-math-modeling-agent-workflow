---
name: mathmodel-suite
description: 当前项目的数学建模统一入口。用户要求完整建模、能力盘点、环境检查、算法安装、科研制图、论文生成、复现或验收时使用；按任务路由到项目插件内对应 Skill。
---

# MathModel Suite

## 项目根目录

`PROJECT_ROOT` 为包含 `AGENTS.md` 和 `config/capabilities.json` 的目录。所有题目产物写入 `PROJECT_ROOT/projects/<项目名>/`。

## 路由

1. 完整建模或任一建模阶段：读取并遵守插件中的 `math-modeling`。
2. 环境检查：运行 `scripts/doctor.ps1`，需要修复时再使用 `doctor`。
3. 算法：读取 `config/algorithms.json`，使用 `.venv/Scripts/python.exe` 实际运行。
4. 科研制图：使用 `mma-figure` 路由，按任务选择 `nature-figure`、`mathmodel-figure-templates`、`paper-diagram` 或其他已安装绘图 Skill。
5. 论文：以 `math-modeling` 论文手为权威流程，配合 `mma-paper` 与 `mma-review`。
6. 复现与验收：运行 `scripts/reproduce.ps1` 与 `scripts/validate.ps1`。

按需加载 Skill；不要因为已全部安装就一次性读取所有入口。
