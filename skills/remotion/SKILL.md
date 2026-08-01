---
name: remotion
description: Best practices for Remotion video creation in React. Use when building programmatic videos with React, including compositions, animations, audio, subtitles, transitions, GIFs, captions, and rendering with Remotion.
---

# Remotion（Codex 适配版）

入口：`skills/remotion/SKILL.md`（官方 remotion-best-practices 技能），其引用的 `rules/`、`assets/`、`src/` 均在本目录内。

## 使用流程

1. Read `skills/remotion/SKILL.md` 获取领域规范。
2. 按需加载 `skills/remotion/rules/*.md`（音频、字幕、转场、字体、Lottie、透明视频等专题）。
3. 新项目在空目录执行 `npx create-video@latest --yes --blank --no-tailwind my-video` 脚手架；渲染用 Remotion CLI。
4. 本项目依赖 Node.js 与 Remotion 包；本机未装依赖时先 `npm install`。
