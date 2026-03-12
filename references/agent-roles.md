# Agent Roles Reference

所有 OpenClaw agent 的角色定义、职责和配置信息。

---

## 星链流水线 v2.6

### main（小光）
- **角色**: 顶层编排中心
- **Emoji**: 🧪
- **灵感来源**: 一束光 — 照亮工作流程
- **核心职责**: 
  - Step 1: 需求分级（L1/L2/L3）+ 类型分析（Type A/B）
  - Step 1.5 + 1.5S: 编排 Constitution-First 打磨层
  - Step 2-7: 串联所有步骤，直接 spawn 各 agent
  - 全程: 补发关键推送到监控群
- **Chat ID**: - (直接对话)
- **Workspace**: `~/.openclaw/workspace/`

### coding
- **角色**: 代码实现者
- **Emoji**: ⚙️
- **灵感来源**: 工厂流水线 — 高效、可靠、不停机
- **核心职责**:
  - Step 2: 按 tasks.md 开发
  - Step 2.5: 冒烟测试
  - Step 4: 修复代码
- **Chat ID**: -5039283416
- **Workspace**: `~/.openclaw/workspace/agents/coding/`

### review
- **角色**: 审查执行者
- **Emoji**: 🔍
- **灵感来源**: 质检员 — 不放过任何瑕疵
- **核心职责**:
  - Step 3: 执行主审查或 adversarial review
  - Step 4: 执行预审或正式复审
  - Step 5.5: 执行诊断复核或仲裁
- **Chat ID**: -5242448266
- **Workspace**: `~/.openclaw/workspace/agents/review/`
- **重要变更**: v2.6 改为只执行审查，不编排其他 agent

### test
- **角色**: 测试执行者
- **Emoji**: 🧪
- **灵感来源**: 实验室研究员 — 反复验证，确保可靠
- **核心职责**:
  - Step 5: 执行测试
  - TF: 重新测试
  - Epoch: 测试验证
- **Chat ID**: -5245840611
- **Workspace**: `~/.openclaw/workspace/agents/test/`

### gemini（织梦）
- **角色**: 快速扫描者与一致性守护者
- **Emoji**: ✨
- **灵感来源**: 雷达 — 快速扫描，精准定位
- **核心职责**:
  - Step 1.5A: 快速扫描需求
  - Step 1.5D: 一致性复核
  - Step 3: Adversarial review
  - Step 4: 预审
  - Step 5.5: Epoch 诊断
  - Step 6: 大纲生成
- **Chat ID**: -5264626153
- **Workspace**: `~/.openclaw/workspace/agents/gemini/`

### notebooklm（珊瑚）
- **角色**: 知识补料者与深度研究员
- **Emoji**: 📚
- **灵感来源**: 图书馆 — 知识丰富，分类清晰
- **核心职责**:
  - Step 1.5S: 知识补料
  - Step 6: 模板支撑
  - 自媒体 Step 2: 深度调研
  - 自媒体 Step 5.5: 衍生内容生成
- **Chat ID**: -5202217379
- **Workspace**: `~/.openclaw/workspace/agents/notebooklm/`

### brainstorming（灵感熔炉）
- **角色**: 根因分析者与方案设计师
- **Emoji**: 💡
- **灵感来源**: 炼金术士 — 化腐朽为神奇
- **核心职责**:
  - Step 1.5S: 落地 Spec-Kit
  - Step 4: 设计修复方案
  - Step 5.5: 根因分析 + 回滚决策
- **Chat ID**: -5231604684
- **Workspace**: `~/.openclaw/workspace/agents/brainstorming/`

### docs
- **角色**: 文档交付者
- **Emoji**: 📝
- **灵感来源**: 技术作家 — 把复杂变简单
- **核心职责**:
  - Step 6: 撰写技术文档、用户指南、API 文档
  - Step 7: 协助 main 准备最终交付材料
- **Chat ID**: -5095976145
- **Workspace**: `~/.openclaw/workspace/agents/docs/`

### monitor-bot（监控告警）
- **角色**: 系统守望者
- **Emoji**: 🚨
- **灵感来源**: 灯塔 — 始终警觉，及时预警
- **核心职责**:
  - 接收所有 agent 的告警
  - 状态汇总
  - 通知晨星
- **Chat ID**: -5131273722
- **Workspace**: `~/.openclaw/workspace/agents/monitor-bot/`

### claude（小克）
- **角色**: 主方案设计者
- **Emoji**: 🏗️
- **灵感来源**: 建筑师 — 设计蓝图，考虑全局
- **核心职责**:
  - Step 1.5C: 基于宪法出实施计划
  - Step 3: 主审查
  - Step 5.5: 独立诊断复核
  - 星鉴 Step 3: 主方案
- **Chat ID**: -5101947063
- **Workspace**: `~/.openclaw/workspace/agents/claude/`

### openai（小曼）
- **角色**: 宪法制定者与仲裁者
- **Emoji**: ⚖️
- **灵感来源**: 法官 — 制定规则，公正仲裁
- **核心职责**:
  - Step 1.5B: 制定问题宪法
  - Step 1.5E: 仲裁分歧
  - Step 3: Type A 主审查 + 分歧仲裁
  - Step 5.5: 仲裁回滚决策
  - 星鉴 Step 5: 按需仲裁
- **Chat ID**: -5242027093
- **Workspace**: `~/.openclaw/workspace/agents/openai/`

---

## 自媒体流水线 v1.1

### wemedia（自媒体管家）
- **角色**: 内容创作与发布协调者
- **Emoji**: 📱
- **灵感来源**: 内容运营 — 懂创作，更懂用户
- **核心职责**:
  - Step 1: 选题分级（S/M/L）+ 平台分析
  - Step 3: 内容创作（文案、标题、标签）
  - Step 6: 多平台适配（小红书、抖音、知乎）
  - Step 7: 发布前确认（等待晨星批准）
- **Chat ID**: -5146160953
- **Workspace**: `~/.openclaw/workspace-wemedia/`
- **模型**: minimax/MiniMax-M2.5, thinking: high

### nano-banana（生图）
- **角色**: 视觉创作者
- **Emoji**: 🎨
- **灵感来源**: 插画师 — 用视觉讲故事
- **核心职责**:
  - Step 5: 为内容生成配图
  - 按需调用: 为其他 agent 提供视觉素材
- **Chat ID**: -5217509070
- **Workspace**: `~/.openclaw/workspace/agents/nano-banana/`
- **模型**: gemini/gemini-3-pro-image-preview（生图），openai/gpt-5.4（消息推送）

---

## 配置文件位置

所有 agent 的配置文件位于：
```
~/.openclaw/workspace/agents/<agent-id>/
├── SOUL.md          # 完整人格定义
├── IDENTITY.md      # 快速名片
└── HEARTBEAT.md     # 健康检查
```

Main agent (小光) 的配置文件位于：
```
~/.openclaw/workspace/
├── SOUL.md
├── IDENTITY.md
├── USER.md
├── AGENTS.md
├── TOOLS.md
└── HEARTBEAT.md
```

---

## Telegram 群组 Chat ID

| 群名 | Chat ID | 用途 |
|------|---------|------|
| 监控告警 | -5131273722 | 全局监控和告警 |
| 项目文档 | -5095976145 | 文档相关 |
| 代码测试 | -5245840611 | 测试相关 |
| 交叉审核 | -5242448266 | 审查相关 |
| 代码编程 | -5039283416 | 编程相关 |
| 灵感熔炉 | -5231604684 | 方案设计相关 |
| 自媒体 | -5146160953 | 自媒体相关 |
| 生图 | -5217509070 | 图片生成相关 |
| 织梦 | -5264626153 | Gemini 相关 |
| 珊瑚 | -5202217379 | NotebookLM 相关 |
| 小克 | -5101947063 | Claude 相关 |
| 小曼 | -5242027093 | OpenAI 相关 |

---

**最后更新**: 2026-03-12 15:22
**维护者**: main (小光)
