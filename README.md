# Claude 配置 → Codex 适配说明

## 来源

- 原始仓库：[Zuojuzhang/my_claude_code_agent_config](https://github.com/Zuojuzhang/my_claude_code_agent_config)（master 分支，2026-08-01 拉取）
- 本目录 `codex-config/`（原 `20260801-codex-config-adapt`，再往前为 `codex-adapted`）是适配后的可安装包；已直接安装到本机 `~/.codex/`

## 适配方式

### 结构转换（Claude → Codex）

| Claude Code 结构 | Codex 落地位置 |
|---|---|
| `~/.claude/CLAUDE.md`（全局约定） | `~/.codex/AGENTS.md`（全局约定，Codex 自动读取） |
| `~/.claude/rules/*.md`（8 个规则文件） | `~/.codex/rules/`，AGENTS.md 按需引用 |
| `~/.claude/agents/*.md`（4 个子代理） | `~/.codex/agents/{code-reviewer,code-writer,ui-designer,ux-reviewer}.toml`（官方 TOML 格式） |
| `~/.claude/personal-ai-os/`（个人 AI 操作系统） | `~/.codex/personal-ai-os/` |
| `~/.claude/design-md/`（74 个品牌设计体系） | `~/.codex/design-md/` |
| `~/.claude/skills/*` | `~/.codex/skills/*` |
| `scripts/`（辅助脚本） | `~/.codex/scripts/`，如官方子代理修复监控脚本 |

### 路径修复

- 全部 `~/.claude/` → `~/.codex/`（57 个文件机械替换）
- 全部 `CLAUDE.md`（配置文件指代）→ `AGENTS.md`
- 原作者的机器路径 `/Users/zrf/...` → `~/workspace/...`（个人业务路径，需按本机实际自定义，已在文档中标注）
- 作者盘符示例 `E:\00 PycharmProjects\...` → `<工作区路径>\...`
- web-access 的 `${CLAUDE_SKILL_DIR}` → `~/.codex/skills/web-access`，并补充 PowerShell 写法说明
- 子代理转为 Codex 官方 TOML 格式（name / description / developer_instructions），Claude 专用字段（tools、model 等）已移除

### 缺失脚本补齐（原仓库漏掉了所有 scripts/）

原仓库的 GitHub 文件树中 **0 个脚本文件**，docx/pdf/pptx/xlsx/impeccable 等技能引用不到脚本。已从上游仓库补齐：

| 技能 | 脚本来源 |
|---|---|
| docx / pdf / pptx / xlsx / webapp-testing / web-artifacts-builder / canvas-design / mcp-builder | anthropics/skills（官方，含 canvas-fonts 字体库） |
| impeccable（107 个脚本） | pbakaus/impeccable 上游 `.claude/skills/impeccable` 完整包（支持 `.codex/hooks.json`） |
| ui-ux-pro-max（search.py 等 6 个脚本） | nextlevelbuilder/ui-ux-pro-max-skill 上游完整包 |
| hv-analysis / storage-analyzer | KKKKhazix/khazix-skills 上游 |
| frontend-slides | zarazhangrui/frontend-slides 上游 |
| web-access | eze-is/web-access 上游 |

## 已安装技能（50 个）

agent-browser、aihot、api-and-interface-design、beautiful-html-templates、bi-dashboard、business-analyst、canvas-design、code-quality-review、context-engineering、darwin-skill、debugging-and-error-recovery、documentation-and-adrs、docx、domain-modeling、doubt-driven-development、feature-breakdown、feishu-doc-beautify、frontend-design、frontend-slides、grilling、grill-with-docs、hv-analysis、impeccable、live-lesson-deck、long-form-writing、mcp-builder、neat-freak、ooux-product-design、pdf、pptx、prd、product-breakdown、product-strategy、prototype、remotion、research、security-and-hardening、shadcn、source-driven-development、storage-analyzer、taste-skill、tdd、ui-copy-check、ui-ux-pro-max、ux-bug-check、wayfinder、web-access、webapp-testing、web-artifacts-builder、xlsx

原 4 个 agents 角色已转为官方子代理，位于 agents/ 目录（TOML 格式），不再以技能形式安装。

## 未安装及原因

| 技能/文件 | 原因 |
|---|---|
| juzhang-lesson-script、khazix-writer、linyi-lyi-scriptwriter | 原作者个人人声/语料蒸馏技能，与本机用户无关 |
| live-qa-archive | 依赖原作者飞书凭证与直播答疑业务，无法独立运行 |
| nuwa-skill（34MB） | 原作者个人品牌与推广物料（含微信二维码），非通用技能 |
| yao-positioning-skill | 原作者课程定位业务，含个人数据 |
| setup-matt-pocock-skills | 元安装器，其目标技能（tdd/wayfinder 等）已直接安装 |
| skill-creator | 本机 Codex 系统已自带同名技能 |
| pdf-publisher | 核心脚本（pdf.sh/html_to_pdf.js/compile_latex.py）为 Moonshot AI 专有资产，公开仓库无脚本，无法正常运行 |
| web-access 的 `.claude-plugin`、taste-skill 的 `.claude-plugin`、各技能的 `skill.sh` | Claude 插件包装，Codex 不需要 |

## 已知问题

### 子代理消息投递（multi-agent v2 + 非 OpenAI 模型）

2026-08-02 实测：当前 Codex 桌面版的 multi-agent v2 会把派工消息加密，DeepSeek 等非 OpenAI 模型的子代理收不到任务内容，spawn、followup、send_message 三种方式均复现。官方 issue [#36321](https://github.com/openai/codex/issues/36321)、[#36376](https://github.com/openai/codex/issues/36376) 登记中，0.147.0-alpha.4 仍未修复。任务文件、收件箱等规避方案实测无效，官方修复前不派子代理，重活本体直做（见 `rules/sub_agent_dispatch.md` 当前环境约束一节）。修复状态由 `~/.codex/scripts/check-subagent-fix.ps1` 每日跟踪。

## 使用须知

1. **全局约定自动生效**：新开 Codex 会话会读取 `~/.codex/AGENTS.md`，其中指向 rules/ 与 personal-ai-os/。
2. **子代理调用**：Codex 从 `~/.codex/agents/` 加载官方子代理（code-reviewer / code-writer / ui-designer / ux-reviewer）。当前 multi-agent 消息 bug 未修复前，官方规则约定不派子代理，重活主线直做（见下方已知问题）。
3. **个人 AI 操作系统**：personal-ai-os 的大部分流程依赖原作者的私有环境（飞书凭证、知识库、课程业务）。未配置部分会自然跳过，启用前需先向用户确认。
4. **运行依赖**（用到时按技能内说明安装）：
   - Python：pdf/pptx/xlsx/docx/webapp-testing/ui-ux-pro-max/storage-analyzer/hv-analysis 需要 python 库（python-pptx、openpyxl、weasyprint、playwright 等）
   - Node.js：impeccable/web-access/frontend-slides/remotion 需要 Node（web-access 要求 Node 22+）
   - shadcn 需要网络访问 npm
   - agent-browser 需要 `npm i -g agent-browser`
5. **live-lesson-deck**：原配的 deck-surgery/verify-deck 脚本未公开，SKILL.md 已加手工回退说明。
6. **保持干净**：不要删除 `~/.codex/skills/.system/`；本适配包全部在 `~/.codex/skills/` 顶层，想卸载直接删对应文件夹即可（删前建议先备份）。
7. **scripts/**：本目录下的辅助脚本安装到 `~/.codex/scripts/`，路径用 `~/.codex/scripts/` 引用，不写具体盘符和用户名，保证多工作区通用。

## 更新方式

重新拉取上游仓库后，把新文件覆盖到本目录 `skills/` 对应位置，再同步到 `~/.codex/skills/`；本文件与 AGENTS.md 中的路径约定不要改动。
