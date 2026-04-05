# Agent Config Generator

为 OpenClaw agent 生成或更新配置文件。

## 自动触发

当用户输入以下关键词时，OpenClaw 会自动调用本 skill：

**触发关键词**：
- "新建 agent"
- "创建 agent"
- "生成 agent 配置"
- "创建新的 agent"
- "帮我创建一个 agent"

**触发后行为**：
1. 读取 SKILL.md
2. 询问用户：agent 名称、角色、模型
3. 调用 `generate-agent-config.sh` 生成最小骨架
4. 验证生成结果

---

## 核心功能

### 模式 1：生成模式（新建 agent）

生成最小骨架（IDENTITY + SOUL + AGENTS）：

```bash
bash ~/.openclaw/skills/agent-config-generator/scripts/generate-agent-config.sh <agent-name> [role] [model]
```

**示例**：
```bash
# 创建 coding agent
bash generate-agent-config.sh coding "代码实现专家" opus

# 创建 wemedia agent
bash generate-agent-config.sh wemedia "自媒体管家" sonnet
```

### 模式 2：重组模式（优化已有 agent）

按主语边界重组内容：

```bash
# 重组所有 agent
bash ~/.openclaw/skills/agent-config-generator/scripts/reorganize-agent-content.sh all

# 重组指定 agent
bash ~/.openclaw/skills/agent-config-generator/scripts/reorganize-agent-content.sh <agent-name>
```

---

## 主语边界

| 内容主语 | 目标文件 |
|---------|---------|
| 我是谁 | IDENTITY.md |
| 我怎么判断和行动 | SOUL.md |
| 我这类任务通常怎么跑 | AGENTS.md |
| 这套工具有什么坑 | TOOLS.md |
| 我们学到了什么 | MEMORY.md |

---

## 脚本清单

| 脚本 | 功能 |
|------|------|
| `generate-agent-config.sh` | 生成新 agent 最小骨架 |
| `reorganize-agent-content.sh` | 按主语边界重组已有 agent 内容 |

---

## 与 architecture-generator 的联动

```
architecture-generator（主入口）
    └── optimize-workspace.sh
        ├── Step 4.5: 调用 reorganize-agent-content.sh
        └── Step 5: 调用 optimize-memory-architecture.sh
```

**独立使用**：
```bash
# 直接生成新 agent
bash generate-agent-config.sh <agent-name> [role] [model]

# 直接重组内容
bash reorganize-agent-content.sh all
```

---

## 安装

```bash
git clone https://github.com/mouseroser/agent-config-generator-skill.git
openclaw plugins install --link ./agent-config-generator-skill
```

---

**最后更新**: 2026-04-05
