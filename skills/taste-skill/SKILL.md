---
name: taste-skill
description: Anti-slop design taste system for landing pages, portfolios, and redesigns. Use when designing or redesigning marketing pages, landing pages, portfolios, event pages, or any page that should not look AI-generated or templated. Includes the main design-taste workflow plus sub-skills for brand, brutalist, minimalist, soft, redesign, stitch, and image-to-code directions.
---

# Taste Skill 集合（Codex 适配版）

本目录是完整技能集合（原 Claude 插件结构保留），入口与子技能如下：

- 主技能：`skills/taste-skill/SKILL.md`（name: design-taste-frontend）
  - Design Read（第 0 节）、三个 Dial（第 1 节）、版式硬规则（第 4.7/4.9/4.10/4.11 节）、图像策略（第 4.8 节）、AI Tells（第 9 节）、Pre-Flight（第 14 节）
- 其他子技能：`skills/brandkit/`、`skills/brutalist-skill/`、`skills/minimalist-skill/`、`skills/soft-skill/`、`skills/redesign-skill/`、`skills/stitch-skill/`、`skills/imagegen-frontend-web/`、`skills/imagegen-frontend-mobile/`、`skills/output-skill/` 等，按需加载

## 使用约定

1. 任何任务先 Read 主技能 `skills/taste-skill/SKILL.md`，按其中的步骤执行。
2. 中文页面必须同时 Read `~/.codex/rules/cn_typography.md` 字体补丁：taste-skill 的字体规则全部基于拉丁字体，中文场景按补丁换字体池，补丁列明的失效规则直接忽略。
3. 本技能覆盖营销类页面（落地页/官网/招募页/作品集/活动页）；产品 UI/看板/多步应用界面用 `frontend-design` 技能。
