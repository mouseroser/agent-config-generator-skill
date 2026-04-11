---
name: agent-config-generator
description: 为 OpenClaw agent 生成或更新配置文件。按当前架构保持文件语义固定、数量可增长。适用于新 agent 创建、现有 agent 配置收口、流水线调整后的批量更新，以及 root / sub-agent 的 SOUL、IDENTITY、HEARTBEAT、AGENTS、TOOLS、MEMORY 骨架修正。当用户说"新建 agent"、"创建 agent"、"生成 agent 配置"等关键词时自动触发。
---

# Agent Config Generator

为 OpenClaw agent 生成或更新配置文件。

## 人格分层策略

本 skill 支持三种 agent 人格类型：

### 1. 功能型 (functional)
- **定位**: 一次性任务执行器
- **生成文件**: SOUL.md (简化) + AGENTS.md (任务契约)
- **记忆系统**: 无
- **示例**: 临时 coding agent、数据处理任务

### 2. 职能型 (operational)
- **定位**: 长期协作角色
- **生成文件**: IDENTITY.md (轻量) + SOUL.md + AGENTS.md (含服务对象段) + memory/
- **记忆系统**: 文件系统 (memory/*.md)
- **示例**: monitor、control-plane、wemedia

### 3. 独立人格型 (independent)
- **定位**: 完整人格实体
- **生成文件**: 完整配置 (IDENTITY + SOUL + USER + AGENTS + MEMORY + HEARTBEAT + TOOLS + memory/)
- **记忆系统**: 独立 memory-lancedb-pro + 文件系统
- **示例**: main

详见：`references/agent-persona-types.md`

## 两种工作模式

### 模式 1：生成模式（新建 agent）

**新签名**：
```bash
bash generate-agent-config.sh <agent-name> <type> [role] [model]

# type 可选值：
# - functional  (功能型)
# - operational (职能型)
# - independent (独立人格型)
```

**使用示例**：
```bash
# 创建功能型 agent（临时任务）
bash generate-agent-config.sh temp-processor functional

# 创建职能型 agent（长期协作）
bash generate-agent-config.sh monitor operational "系统监控哨" sonnet

# 创建独立人格型 agent（面向用户）
bash generate-agent-config.sh assistant independent "个人助理" opus
```

### 模式 2：重组模式（优化已有 agent）

**执行内容**：
1. 读取所有 agent 配置文件
2. 按主语边界判断内容归属
3. 移动内容到正确文件
4. 保留所有内容，不删除

**主语边界**：
| 内容主语 | 目标文件 |
|---------|---------|
| 我是谁 | IDENTITY.md |
| 我怎么判断和行动 | SOUL.md |
| 我这类任务通常怎么跑 | AGENTS.md |
| 这套工具有什么坑 | TOOLS.md |
| 我们学到了什么 | MEMORY.md |

**执行脚本**：
```bash
# 重组所有 agent
bash ~/.openclaw/skills/agent-config-generator/scripts/reorganize-agent-content.sh all

# 重组指定 agent
bash ~/.openclaw/skills/agent-config-generator/scripts/reorganize-agent-content.sh <agent-name>
```

## 定位

## 自动触发

当用户输入以下关键词时，OpenClaw 会自动调用本 skill：

**触发关键词**：
- "新建 agent"
- "创建 agent"
- "生成 agent 配置"
- "创建新的 agent"
- "帮我创建一个 agent"

**触发后行为**：
1. 读取本 SKILL.md
2. 询问用户：agent 名称、角色、模型
3. 调用 `generate-agent-config.sh` 生成最小骨架
4. 验证生成结果


**独立工作为主，联动 architecture-generator 为辅。**

- agent-config-generator 可以独立工作，不需要依赖 architecture-generator
- architecture-generator 验证/优化 workspace 时，会读取 agent 配置但不修改
- 两个 skill 通过 `shared-context/AGENT-FILE-ARCHITECTURE.md` 共享架构口径

## 与 architecture-generator 的联动

**职责边界**:
- **architecture-generator**: 结构优化（补全文件、修复位置）
- **agent-config-generator**: 内容优化（生成配置、重组内容）

**工作流**:
```
# 新建 agent（直接调用脚本）
bash generate-agent-config.sh <agent-name> <type> [role] [model]

# 内容重组
bash reorganize-agent-content.sh all

# 或通过 architecture-generator 联动调用
bash optimize-workspace.sh
  → 提示：是否重组内容？
  → 用户确认后调用 reorganize-agent-content.sh
```

## 核心原则

### 文件语义固定
- `IDENTITY.md`：名片
- `SOUL.md`：人格与边界
- `AGENTS.md`：执行手册
- `TOOLS.md`：环境坑位
- `MEMORY.md`：长期伤疤与护栏

### 主语边界判断
- 我是谁 → `IDENTITY.md`
- 我怎么判断和行动 → `SOUL.md`
- 我这类任务通常怎么跑 → `AGENTS.md`
- 这套工具有什么坑 → `TOOLS.md`
- 我们学到了什么 → `MEMORY.md`

### 允许增长，不做 blanket trimming
- 不把 sub-agent 永久锁死在三件套
- 不因为"看起来重复"就删文件
- 只做主语纠偏、内容瘦身、结构整理

## Required Read

执行前必读：
1. `references/agent-config-template.md`
2. `references/agent-roles.md`
3. `references/agent-persona-types.md` ← 新增
4. `~/.openclaw/workspace/shared-context/AGENT-FILE-ARCHITECTURE.md`
5. `~/.openclaw/workspace/shared-context/AGENT-PERSONA-STRATEGY.md` ← 新增
6. `~/.openclaw/workspace/AGENTS.md`
7. 最新流水线 skill / contract（如果是流水线调整触发）

## 脚本清单

| 脚本 | 功能 |
|------|------|
| `generate-agent-config.sh` | 生成新 agent 最小骨架 |
| `reorganize-agent-content.sh` | 按主语边界重组已有 agent 内容 |
