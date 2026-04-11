#!/bin/bash
# generate-agent-config.sh - 生成新 agent 配置（支持人格分层）
# 用法: bash generate-agent-config.sh <agent-name> <type> [role] [model]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "用法: bash generate-agent-config.sh <agent-name> <type> [role] [model]"
    echo ""
    echo "type 可选值:"
    echo "  functional  - 功能型（一次性任务）"
    echo "  operational - 职能型（长期协作）"
    echo "  independent - 独立人格型（面向用户）"
    echo ""
    echo "示例:"
    echo "  bash generate-agent-config.sh temp-processor functional"
    echo "  bash generate-agent-config.sh monitor operational '系统监控哨' sonnet"
    echo "  bash generate-agent-config.sh assistant independent '个人助理' opus"
    exit 1
fi

AGENT_NAME="$1"
AGENT_TYPE="$2"
AGENT_ROLE="${3:-待定义}"
AGENT_MODEL="${4:-sonnet}"
WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/.openclaw/workspace}"
AGENT_DIR="$WORKSPACE_DIR/agents/$AGENT_NAME"
AGENT_STATE_DIR="$HOME/.openclaw/agents/$AGENT_NAME"

echo "=== 生成 agent 配置: $AGENT_NAME (类型: $AGENT_TYPE) ==="
echo ""

# 验证 type
case "$AGENT_TYPE" in
    functional|operational|independent)
        ;;
    *)
        echo "❌ 错误: 未知的 agent 类型: $AGENT_TYPE"
        echo "可选值: functional, operational, independent"
        exit 1
        ;;
esac

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
    rm -rf "$AGENT_STATE_DIR"
fi

echo "📁 创建目录: $AGENT_DIR"
mkdir -p "$AGENT_DIR"
echo ""

# 选择模板目录
TEMPLATE_DIR="$SKILL_DIR/templates/${AGENT_TYPE}-agent"

if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "❌ 错误: 模板目录不存在: $TEMPLATE_DIR"
    exit 1
fi

echo "📝 从模板生成配置文件..."
echo ""

# 复制模板文件并替换变量
for template_file in "$TEMPLATE_DIR"/*; do
    if [ -f "$template_file" ]; then
        filename=$(basename "$template_file")
        target_file="$AGENT_DIR/$filename"
        
        # 替换模板变量
        sed -e "s/\${AGENT_NAME}/$AGENT_NAME/g" \
            -e "s/\${ROLE}/$AGENT_ROLE/g" \
            -e "s/\${MODEL}/$AGENT_MODEL/g" \
            "$template_file" > "$target_file"
        
        echo "✅ $filename"
    fi
done

# 根据类型创建额外目录和配置
case "$AGENT_TYPE" in
    operational)
        # 创建 memory 目录
        mkdir -p "$AGENT_DIR/memory"
        echo "✅ memory/ (日志目录)"
        
        # 禁用 memory-lancedb-pro
        mkdir -p "$AGENT_STATE_DIR/agent"
        cat > "$AGENT_STATE_DIR/agent/openclaw.json" << 'EOF'
{
  "plugins": {
    "entries": {
      "memory-lancedb-pro": {
        "enabled": false
      }
    }
  }
}
EOF
        echo "✅ agentDir/openclaw.json (禁用 memory-lancedb-pro)"
        ;;
    
    independent)
        # 创建完整 memory 结构
        mkdir -p "$AGENT_DIR/memory/topics"
        mkdir -p "$AGENT_DIR/memory/runtime-maintenance"
        echo "✅ memory/ (完整记忆结构)"
        
        # 启用 memory-lancedb-pro
        mkdir -p "$AGENT_STATE_DIR/agent"
        cat > "$AGENT_STATE_DIR/agent/openclaw.json" << EOF
{
  "plugins": {
    "entries": {
      "memory-lancedb-pro": {
        "enabled": true,
        "config": {
          "embedding": {
            "provider": "openai-compatible",
            "apiKey": "ollama",
            "baseURL": "http://127.0.0.1:11434/v1",
            "model": "bge-m3",
            "dimensions": 1024,
            "chunking": true,
            "taskQuery": "retrieval.query",
            "taskPassage": "retrieval.passage",
            "normalized": true
          },
          "dbPath": "~/.openclaw/agents/$AGENT_NAME/memory/lancedb-pro"
        }
      }
    }
  }
}
EOF
        echo "✅ agentDir/openclaw.json (启用 memory-lancedb-pro)"
        ;;
esac

echo ""
echo "✅ Agent 配置生成完成"
echo ""
echo "📊 生成的文件:"
case "$AGENT_TYPE" in
    functional)
        echo "   - SOUL.md (执行风格)"
        echo "   - AGENTS.md (任务契约)"
        ;;
    operational)
        echo "   - IDENTITY.md (轻量名片)"
        echo "   - SOUL.md (判断原则)"
        echo "   - AGENTS.md (执行手册 + 服务对象段)"
        echo "   - memory/ (日志目录)"
        ;;
    independent)
        echo "   - IDENTITY.md (完整名片)"
        echo "   - SOUL.md (完整人格)"
        echo " - USER.md (服务对象)"
        echo "   - AGENTS.md (完整执行手册)"
        echo "   - MEMORY.md (长期记忆索引)"
        echo "   - HEARTBEAT.md (健康检查)"
        echo "   - TOOLS.md (工具链坑位)"
        echo "   - memory/ (完整记忆结构)"
        ;;
esac

echo ""
echo "💡 后续步骤:"
case "$AGENT_TYPE" in
    functional)
        echo "   1. 编辑 AGENTS.md 定义任务契约（输入/输出/执行规则）"
        echo "   2. 按需调整 SOUL.md 的执行风格"
        ;;
    operational)
        echo "   1. 编辑 IDENTITY.md 完善名字/角色/emoji"
        echo "   2. 编辑 SOUL.md 定义判断原则和边界"
        echo "   3. 编辑 AGENTS.md 定义职责和执行规则"
        echo "   4. 按需添加 MEMORY.md / HEARTBEAT.md / TOOLS.md"
        ;;
    independent)
        echo "   1. 编辑所有配置文件，完善细节"
        echo "   2. 在 openclaw.json 中添加 agent 到 agents.list"
        echo "   3. 配置 bindings 路由规则"
        echo "   4. 重启 gateway: openclaw gateway restart"
        ;;
esac

echo ""
echo "📍 Agent 位置:"
echo "   Workspace: $AGENT_DIR"
echo "   State dir: $AGENT_STATE_DIR"
echo ""
echo "✅ 完成"
