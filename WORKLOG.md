# WORKLOG

## 2026-08-01 21:00

把 Zuojuzhang/my_claude_code_agent_config 从 Claude 配置适配为 Codex 配置并安装到本机 `~/.codex`。

- 结构转换：CLAUDE.md → 全局 AGENTS.md；rules、personal-ai-os、design-md 平移；4 个子代理转为技能（含 agents/openai.yaml）
- 路径修复：全部 `~/.claude` → `~/.codex`、`CLAUDE.md` → `AGENTS.md`、作者 `/Users/zrf/...` 路径改 `~/workspace/...`
- 原仓库漏掉全部 scripts/，从 anthropics/skills、pbakaus/impeccable、KKKKhazix/khazix-skills、nextlevelbuilder/ui-ux-pro-max-skill、zarazhangrui/frontend-slides、eze-is/web-access 上游补齐
- 弃用 9 项：个人人声/业务技能（juzhang、khazix、linyi、live-qa-archive、nuwa、yao）、setup-matt-pocock-skills、skill-creator（系统自带）、pdf-publisher（Moonshot 专有脚本不可得）
- 已安装 54 个技能 + rules + design-md + personal-ai-os，全部通过 frontmatter 校验

## 2026-08-02 00:24

按工作区级规则（新 AGENTS.md）重构工作区结构。

- 根目录只保留 AGENTS.md 与 `_shared/`、`_archive/`、`_template/` 三个约定目录
- `codex-adapted` 更名为规范子项目 `20260801-codex-config-adapt`，`README-适配说明.md` 改名 `README.md`
- 新建 `_template/README.md` 模板、本 WORKLOG.md
- 清理下载缓存（约 275MB）到 `_shared/temp-downloads` 下的空目录，等待手动删除
