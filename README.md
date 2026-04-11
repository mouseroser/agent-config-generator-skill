# Agent Config Generator

[![GitHub](https://img.shields.io/badge/GitHub-mouseroser-blue?logo=github)](https://github.com/mouseroser/agent-config-generator-skill)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-Skill-orange.svg)](https://openclaw.ai)

为 OpenClaw agent 生成和优化配置文件的专业工具。

## ✨ 特性

- 🎯 **智能生成** - 根据 agent 类型自动生成最小骨架
- 🔄 **内容重组** - 按主语边界自动重组配置内容
- 🤖 **自动触发** - 支持关键词自动触发
- 📋 **三种类型** - 支持功能型、职能型、独立人格型 agent
- 🔧 **无损优化** - 保留所有内容，只优化结构

## 🚀 快速开始

### 安装

```bash
cd ~/.openclaw/skills
git clone https://github.com/mouseroser/agent-config-generator-skill.git agent-config-generator
```

### 使用

```bash
# 创建新 agent
bash ~/.openclaw/skills/agent-config-generator/scripts/generate-agent-config.sh <agent-name> <type> [role] [model]

# 示例：创建职能型 agent
bash generate-agent-config.sh monitor operational "系统监控哨" sonnet
```

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
cd ~/.openclaw/skills
git clone https://github.com/mouseroser/agent-config-generator-skill.git agent-config-generator
```

或手动下载后放到 `~/.openclaw/skills/agent-config-generator/`

---

## 📝 更新日志

### 2026-04-11
- 优化 README 文档
- 添加徽章和快速开始指南
- 完善使用示例

### 2026-04-05
- 初始版本发布

---

## 📄 License

MIT License - 详见 [LICENSE](LICENSE) 文件

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📧 联系

- GitHub: [@mouseroser](https://github.com/mouseroser)
- OpenClaw Community: [Discord](https://discord.com/invite/clawd)
