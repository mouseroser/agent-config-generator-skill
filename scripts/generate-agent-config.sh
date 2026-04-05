#!/bin/bash
# generate-agent-config.sh - 生成新 agent 最小骨架
# 用法: bash generate-agent-config.sh <agent-name> [role] [model]

set -e

if [ -z "$1" ]; then
    echo "用法: bash generate-agent-config.sh <agent-name> [role] [model]"
    echo ""
    echo "示例:"
    echo "  bash generate-agent-config.sh coding '代码实现专家' opus"
    echo "  bash generate-agent-config.sh wemedia '自媒体管家' sonnet"
    exit 1
fi

AGENT_NAME="$1"
AGENT_ROLE="${2:-待定义}"
AGENT_MODEL="${3:-sonnet}"
WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/.openclaw/workspace}"
AGENT_DIR="$WORKSPACE_DIR/agents/$AGENT_NAME"

echo "=== 生成 agent 最小骨架: $AGENT_NAME ==="
echo ""

# 检查是否已存在
if [ -d "$AGENT_DIR" ]; then
    echo "⚠️  Agent 已存在: $AGENT_DIR"
    echo "是否覆盖？(y/n)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "❌ 取消生成"
        exit 1
    fi
    echo "🗑️  删除旧配置..."
    rm -rf "$AGENT_DIR"
fi

echo "📁 创建目录: $AGENT_DIR"
mkdir -p "$AGENT_DIR"
echo ""

echo "📝 生成最小骨架（IDENTITY + SOUL + AGENTS）..."
echo ""

# 生成 IDENTITY.md
cat > "$AGENT_DIR/IDENTITY.md" << EOF
# IDENTITY.md

- **名字**: ${AGENT_NAME}
- **角色**: ${AGENT_ROLE}
- **气质**: [待定义]
- **Emoji**: 🤖
- **灵感来源**: [待定义]
EOF
echo "✅ IDENTITY.md"

# 生成 SOUL.md
cat > "$AGENT_DIR/SOUL.md" << EOF
# SOUL.md（${AGENT_NAME}）

## 核心身份

${AGENT_ROLE}

## 你的角色

[待定义]

## 你的原则

1. [待定义]
2. [待定义]

## 你的边界

- [待定义]

## 你的风格

- [待定义]
EOF
echo "✅ SOUL.md"

# 生成 AGENTS.md
cat > "$AGENT_DIR/AGENTS.md" << EOF
# AGENTS.md - ${AGENT_NAME}

## 身份
- **Agent ID**: ${AGENT_NAME}
- **角色**: ${AGENT_ROLE}
- **模型**: ${AGENT_MODEL}

## 职责

[待定义]

## 执行规则

[待定义]

## 边界

[待定义]
EOF
echo "✅ AGENTS.md"

echo ""
echo "✅ 最小骨架生成完成"
echo ""
echo "📊 生成的文件:"
echo "   - IDENTITY.md (名片)"
echo "   - SOUL.md (人格与边界)"
echo "   - AGENTS.md (执行手册)"
echo ""
echo "💡 后续可按需添加:"
echo "   - TOOLS.md (环境坑位)"
echo "   - MEMORY.md (长期教训)"
echo "   - HEARTBEAT.md (值班清单)"
echo "   - memory/ (记忆目录)"
echo ""
echo "✅ Agent 配置生成完成: $AGENT_DIR"
