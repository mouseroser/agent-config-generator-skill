# Agent Config Template

当前模板定义的是**文件职责**，不是"固定文件数量"。

---

## 总原则

- **文件语义固定，文件数量可增长**
- agent 可以从最小骨架启动，但不能被静态锁死在三件套
- 优化配置时，只做主语纠偏、内容瘦身、结构整理；不做 blanket trimming

---

## 文件职责

### `IDENTITY.md`
只做身份卡。

放：
- 名字
- 角色
- 气质
- emoji
- 灵感来源

不放：
- 大段规则
- 流程说明
- 历史记录

### `SOUL.md`
只放 agent 自己的内在操作方式。

标准骨架：
- 核心身份
- 你的角色
- 你的原则
- 你的边界
- 你的风格

### sub-agent 的"服务对象"信息
默认写入 `AGENTS.md` 的"服务对象"段，而不是机械恢复独立 `USER.md`。

适合承载：
- 服务对象基本信息
- 协作偏好
- 少量稳定硬规则

独立 `USER.md` 只保留给：
- main
- 或长期确有必要的特殊 agent

### `AGENTS.md`
执行手册，不是人格文件。

适合承载：
- 每次会话先读什么
- 职责
- 执行规则
- 通知规则
- 记忆规则
- 稳定 workflow / contract / handoff 习惯

### `HEARTBEAT.md`
值班 runbook。

适合承载：
- 检查项
- 具体命令
- 时间条件
- 异常输出格式

### `TOOLS.md`
只记环境的脾气。

适合承载：
- 路径坑
- schema 坑
- CLI / gateway / proxy / 浏览器怪癖
- 工作目录约定
- 输入输出路径

### `MEMORY.md`
只放长期内容，不放当天流水账。

统一骨架：
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

### `memory/YYYY-MM-DD.md`
当天作战日志。

适合承载：
- 当天事件
- 当天判断
- 当天错误
- 当天修复
- 值得后续晋升到 `MEMORY.md` 的候选项

### `BOOTSTRAP.md`
启动引导。

只放：
- 先读哪些文件
- 启动顺序
- 最小必要提醒

不重复：
- IDENTITY 正文
- SOUL 正文
- AGENTS 正文

---

## 模板约束

### SOUL.md
- 必须有"你的边界"
- 不能只有人格没有刹车

### IDENTITY.md
- 必须轻量
- 不把大段规则塞进去

### HEARTBEAT.md
- 必须命令化、时间感知
- 不写成说明文

### 服务对象信息
- sub-agent 默认写入 `AGENTS.md` 的"服务对象"段
- 不默认复制 root `USER.md`
- 只有长期确有必要时才恢复独立 `USER.md`

### MEMORY.md
- 不写执行手册
- 不写路径说明
- 不写模板/流程定义
- 不写当天流水账

---

## 推荐写法

### AGENTS.md 的"服务对象"段（sub-agent 默认）
```markdown
## 服务对象
- **<服务对象称呼>** | <时区> | <语言> | <沟通风格>
- 明确命令优先，不擅自改写命令含义
- 遇到问题先修再报，不停在解释上
```

### USER.md（仅 main / 特殊长期 agent）
```markdown
# USER.md

- **名字**: <真实姓名>
- **称呼**: <常用称呼>
- **时区**: <时区>

---

## 硬规则
- 明确命令优先，不要擅自改写命令含义
- 外部发布、危险操作、不确定事项先问
```

### MEMORY.md
```markdown
# MEMORY.md - {{agent_name}}

## 血泪教训
- ...

## 错误示范 / 反模式
- ...

## 长期稳定规则
- ...

## 长期偏好
- ...
```

### BOOTSTRAP.md
```markdown
# BOOTSTRAP.md - {{agent_name}}

## 启动顺序
1. 读取 `IDENTITY.md`
2. 读取 `SOUL.md`
3. 读取 `AGENTS.md`
4. 读取 `AGENTS.md` 的"服务对象"段（sub-agent）或 `USER.md`（main）
5. 读取 `MEMORY.md`（如有）
6. 读取 `TOOLS.md`（如有）
```

---

**最后更新**: 2026-04-05
**维护者**: architecture-generator
