---
name: beautiful-html-templates
description: Build beautiful HTML presentation decks by picking from a curated template library, cloning the chosen template, and replacing placeholder content with real content. Use when the user asks for an HTML deck, slides, pitch deck, research synthesis, brand manifesto, classroom kickoff deck, or any presentation that should look designed rather than templated.
---

# Beautiful HTML Templates（Codex 适配版）

本技能来自 zarazhangrui/beautiful-html-templates，原仓库用 `AGENTS.md` 作为操作手册。Codex 适配版把入口收敛为标准的 `SKILL.md`，其余文件保持原结构。

## 使用流程

1. 完整 Read 本目录下的 `AGENTS.md`，它是唯一操作手册：从用户简报出发，先问场合与氛围，再读 `index.json` 挑选 3 个候选模板，生成标题页预览，等用户选定后克隆模板并替换内容。
2. 模板资源按需读取：`templates/<slug>/design.md`（视觉系统）、`templates/<slug>/template.html`（页面结构）、`templates/<slug>/template.json`（元数据）、`runtime/deck-stage.js`（舞台脚本）。
3. 产出为自包含 HTML 文件；兄弟资源（css/js）与模板保持同一目录结构。

## Windows / Codex 环境差异

- 原手册里的 `open <path>`（macOS 命令）在本机替换为 `Start-Process <path>` 或直接用浏览器插件打开本地文件。
- 预览文件用浏览器打开后，截图或描述给用户确认；用户选定后再产出最终 deck。
- 截图目录 `screenshots/` 仅供候选筛选参考，不要混入产出物。
