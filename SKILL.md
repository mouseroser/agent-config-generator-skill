---
name: agent-config-generator
description: 为 OpenClaw agent 生成或更新配置文件，按当前架构保持文件语义固定、文件数量可增长。适用于新 agent 创建、现有 agent 配置收口、流水线调整后的批量更新，以及 root / sub-agent 的 SOUL、IDENTITY、HEARTBEAT、AGENTS、TOOLS、MEMORY 骨架修正；当 sub-agent 需要服务对象信息时，默认写入 AGENTS.md 的“服务对象”段，而不是机械恢复独立 USER.md。 
---

# Agent Config Generator

为 OpenClaw agent 生成或更新配置文件。

## 当前口径

不是“默认三件套永远够用”，而是：
- **文件语义固定**
- **文件数量可增长**
- agent 可从最小骨架启动，但应随真实使用自然长出更多文件

当前文件职责：
- `IDENTITY.md`：名片
- `SOUL.md`：人格与边界
- `AGENTS.md`：执行手册（sub-agent 默认也承载"服务对象"段）
- `HEARTBEAT.md`：值班清单
- `TOOLS.md`：环境坑位
- `MEMORY.md`：长期伤疤与护栏
- `memory/YYYY-MM-DD.md`：当天账本与晋升池

跨 agent 共享文档：
- `shared-context/THESIS.md`：当前世界观
- `shared-context/FEEDBACK-LOG.md`：跨 agent 纠偏账本
- `shared-context/SIGNALS.md`：外部信号池

## Required Read

执行前必读：
1. `references/agent-config-template.md`
2. `references/agent-roles.md`
3. `~/.openclaw/workspace/shared-context/AGENT-FILE-ARCHITECTURE.md`
4. `~/.openclaw/workspace/AGENTS.md`
5. 最新流水线 skill / contract（如果是流水线调整触发）

## 生成 / 更新原则

### 1. 先判主语，再改文件
只回答这段内容属于谁：
- 我是谁 → `IDENTITY.md`
- 我怎么判断和行动 → `SOUL.md`
- 我在帮谁 → `AGENTS.md` 的"服务对象"段（sub-agent）或 `USER.md`（main）
- 我这类任务通常怎么跑 → `AGENTS.md`
- 这套工具有什么坑 → `TOOLS.md`
- 我们学到了什么 → `MEMORY.md`

### 2. 允许增长，不做 blanket trimming
- 不把 sub-agent 永久锁死在三件套
- 不因为“看起来重复”就删文件
- 只做主语纠偏、内容瘦身、结构整理

### 3. MEMORY.md 统一骨架
main 与 sub-agent 的 `MEMORY.md` 统一骨架：
1. 血泪教训
2. 错误示范 / 反模式
3. 长期稳定规则
4. 长期偏好（可选）

写入门槛：至少满足以下 3 条才进 MEMORY.md：
- 高代价
- 可复发
- 已验证
- 长期有效
- 不写进去以后大概率还会再犯

### 4. 服务对象信息默认在 AGENTS.md
- sub-agent 默认把服务对象信息写入 `AGENTS.md` 的"服务对象"段
- 只有长期确有必要时才恢复独立 `USER.md`
- main 保留独立 `USER.md`

### 5. BOOTSTRAP.md 只是启动引导
- 只保留“先读哪些文件”的引导
- 不重复 IDENTITY / SOUL / AGENTS 的正文

## 批量更新时必须同步的架构结论

如果变更来源是 2026-03-28 之后的最终架构口径，必须体现：
- main 是人类协作入口 + 主会话编排
- control-plane 是控制面宿主
- routine heartbeat / cron 不再由 main 承担
- `DAILY-INTEL.md` 是全局情报池
- `intel/media-ops/DAILY-SIGNAL-BRIEF.md` 是自媒体信号筛选层
- sub-agent 文件可增长，但必须主语清晰

## 输出要求

更新 agent 配置时：
1. 不追求所有 agent 文件数量一致
2. 只追求同类文件语义一致
3. 若发现内容主语错位，移动到正确文件；不要直接删除有效知识
4. 若文件内容只是模板噪音，可瘦身，但必须保留未来增长空间

## Notes

- 若是 root / sub-agent 的批量收口，优先更新 references，而不是在 SKILL.md 里堆版本历史
- 若要动 `MEMORY.md`，先确认写入内容满足长期记忆门槛
- 若要动 `AGENTS.md`，优先保留稳定 workflow，不要把 contract 全部挪回 spawn prompt
