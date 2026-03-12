# Agent Config Generator

为 OpenClaw agent 生成或更新完整配置文件的 skill。

## 快速开始

### 创建新 agent

```
使用 agent-config-generator skill 为新 agent 生成配置：
- Agent ID: analytics
- 角色: 数据分析者
- Emoji: 📊
- 灵感来源: 数据科学家
```

### 更新现有 agent

```
使用 agent-config-generator skill 更新 review agent：
- 变更: 角色从"交叉审核中枢"改为"审查执行者"
- 移除职责: 编排 coding/test/gemini
- 新增约束: 只执行审查，不编排其他 agent
```

### 批量验证

```
使用 agent-config-generator skill 验证所有 agent 配置的完整性
```

## 文件结构

```
agent-config-generator/
├── SKILL.md                              # Skill 主文档
├── README.md                             # 本文件
└── references/
    ├── agent-config-template.md          # 配置模板和风格指南
    └── agent-roles.md                    # 所有 agent 的角色定义
```

## 生成的配置文件

每个 agent 会生成三个文件：

1. **SOUL.md** - 完整人格定义
   - 核心身份
   - 角色职责
   - 工作原则
   - 风格特点
   - 硬性约束
   - 推送规范
   - 协作边界

2. **IDENTITY.md** - 快速名片
   - 名字、角色、气质、Emoji、灵感来源
   - 原则、风格、不做的事

3. **HEARTBEAT.md** - 健康检查
   - 需要监控的内容
   - 故障恢复流程
   - 关键原则

## 使用场景

### 场景 1: 创建新 agent
当需要添加新的 agent 到系统时，使用本 skill 生成标准配置。

### 场景 2: 流水线调整
当星链/自媒体/星鉴流水线调整后，使用本 skill 批量更新受影响的 agent 配置。

### 场景 3: 角色变更
当某个 agent 的角色或职责发生变化时，使用本 skill 更新配置。

### 场景 4: 配置验证
定期使用本 skill 验证所有 agent 配置的完整性。

## 风格特点

- **人格鲜明**: 每个 agent 都有独特的灵感来源和性格
- **职责清晰**: 明确"做什么"和"不做什么"
- **风格统一**: 所有 agent 遵循相同的配置结构
- **可操作性**: 硬性约束具体，可验证

## 示例

### 已生成的 agent 配置

所有 12 个 agent 的配置已生成：
- ✅ main（小光）- 顶层编排中心 🧪
- ✅ coding - 代码实现者 ⚙️
- ✅ review - 审查执行者 🔍
- ✅ test - 测试执行者 🧪
- ✅ gemini（织梦）- 快速扫描者 ✨
- ✅ notebooklm（珊瑚）- 知识补料者 📚
- ✅ brainstorming（灵感熔炉）- 根因分析者 💡
- ✅ docs - 文档交付者 📝
- ✅ wemedia（自媒体管家）- 内容创作者 📱
- ✅ nano-banana（生图）- 视觉创作者 🎨
- ✅ monitor-bot（监控告警）- 系统守望者 🚨
- ✅ claude（小克）- 主方案设计者 🏗️
- ✅ openai（小曼）- 宪法制定者 ⚖️

## 维护

- **定期验证**: 每月验证一次所有 agent 配置的完整性
- **流水线同步**: 流水线调整后立即更新相关 agent 配置
- **版本记录**: 重大变更记录在 `references/agent-roles.md`

## 版本历史

- v1.0 (2026-03-12): 初始版本
  - 支持创建新 agent 配置
  - 支持更新现有 agent 配置
  - 支持批量验证
  - 包含完整的模板和风格指南

---

**创建时间**: 2026-03-12 15:24
**维护者**: main (小光)
