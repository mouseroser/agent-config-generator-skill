#!/bin/bash
# reorganize-agent-content.sh - 按主语边界重组 agent 配置内容
# 用法: bash reorganize-agent-content.sh [agent-name|all]

set -e

WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/.openclaw/workspace}"
AGENT_NAME="${1:-all}"

echo "=== Agent 配置内容重组 ==="
echo ""

# 读取 AGENT-FILE-ARCHITECTURE.md
ARCHITECTURE_FILE="$WORKSPACE_DIR/shared-context/AGENT-FILE-ARCHITECTURE.md"
if [ ! -f "$ARCHITECTURE_FILE" ]; then
    echo "⚠️  未找到 AGENT-FILE-ARCHITECTURE.md"
    echo "   请先运行 architecture-generator 初始化 workspace"
    exit 1
fi

echo "📖 读取文件语义定义: $ARCHITECTURE_FILE"
echo ""

# 主语边界映射
declare -A SUBJECT_MAP=(
    ["我是谁"]="IDENTITY.md"
    ["我怎么判断和行动"]="SOUL.md"
    ["我在帮谁"]="AGENTS.md"
    ["我这类任务通常怎么跑"]="AGENTS.md"
    ["这套工具有什么坑"]="TOOLS.md"
    ["我们学到了什么"]="MEMORY.md"
)

# 确定要处理的 agent 列表
if [ "$AGENT_NAME" = "all" ]; then
    echo "🔍 扫描所有 agent..."
    AGENTS=()
    
    # main agent
    if [ -f "$WORKSPACE_DIR/AGENTS.md" ]; then
        AGENTS+=("main")
    fi
    
    # sub-agents
    if [ -d "$WORKSPACE_DIR/agents" ]; then
        for agent_dir in "$WORKSPACE_DIR/agents"/*; do
            if [ -d "$agent_dir" ] && [ -f "$agent_dir/AGENTS.md" ]; then
                AGENTS+=("$(basename "$agent_dir")")
            fi
        done
    fi
    
    if [ ${#AGENTS[@]} -eq 0 ]; then
        echo "❌ 未找到任何 agent 配置"
        exit 1
    fi
    
    echo "📊 找到 ${#AGENTS[@]} 个 agent: ${AGENTS[*]}"
    echo ""
else
    AGENTS=("$AGENT_NAME")
fi

# 处理每个 agent
for agent in "${AGENTS[@]}"; do
    echo "=== 处理 agent: $agent ==="
    
    # 确定 agent 目录
    if [ "$agent" = "main" ]; then
        AGENT_DIR="$WORKSPACE_DIR"
    else
        AGENT_DIR="$WORKSPACE_DIR/agents/$agent"
    fi
    
    if [ ! -d "$AGENT_DIR" ]; then
        echo "⚠️  Agent 目录不存在: $AGENT_DIR"
        continue
    fi
    
    # 检查配置文件
    CONFIG_FILES=()
    for file in IDENTITY.md SOUL.md AGENTS.md TOOLS.md MEMORY.md HEARTBEAT.md USER.md; do
        if [ -f "$AGENT_DIR/$file" ]; then
            CONFIG_FILES+=("$file")
        fi
    done
    
    if [ ${#CONFIG_FILES[@]} -eq 0 ]; then
        echo "⚠️  未找到配置文件"
        continue
    fi
    
    echo "📄 找到配置文件: ${CONFIG_FILES[*]}"
    echo ""
    
    # 创建备份
    BACKUP_DIR="$AGENT_DIR/.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    for file in "${CONFIG_FILES[@]}"; do
        cp "$AGENT_DIR/$file" "$BACKUP_DIR/"
    done
    echo "💾 备份已创建: $BACKUP_DIR"
    echo ""
    
    # 分析内容主语（简化版：基于关键词）
    echo "🔍 分析内容主语..."
    
    # 这里是简化实现，实际应该用更复杂的逻辑
    # 当前只做基本检查：
    # 1. SOUL.md 不应包含执行步骤
    # 2. AGENTS.md 不应包含人格描述
    # 3. MEMORY.md 不应包含路径说明
    
    ISSUES_FOUND=false
    
    # 检查 SOUL.md
    if [ -f "$AGENT_DIR/SOUL.md" ]; then
        if grep -q "Step\|步骤\|执行\|spawn\|sessions_send" "$AGENT_DIR/SOUL.md"; then
            echo "⚠️  SOUL.md 包含执行步骤（应移至 AGENTS.md）"
            ISSUES_FOUND=true
        fi
    fi
    
    # 检查 AGENTS.md
    if [ -f "$AGENT_DIR/AGENTS.md" ]; then
        if grep -q "人格\|气质\|风格\|原则.*：" "$AGENT_DIR/AGENTS.md" | head -5; then
            echo "⚠️  AGENTS.md 可能包含人格描述（应移至 SOUL.md）"
            ISSUES_FOUND=true
        fi
    fi
    
    # 检查 MEMORY.md
    if [ -f "$AGENT_DIR/MEMORY.md" ]; then
        if grep -q "路径\|目录\|~/.openclaw" "$AGENT_DIR/MEMORY.md" | grep -v "记忆"; then
            echo "⚠️  MEMORY.md 可能包含路径说明（应移至 TOOLS.md）"
            ISSUES_FOUND=true
        fi
    fi
    
    if [ "$ISSUES_FOUND" = false ]; then
        echo "✅ 未发现明显的主语错位"
        rm -rf "$BACKUP_DIR"
    else
        echo ""
        echo "💡 建议："
        echo "   1. 手动检查上述问题"
        echo "   2. 移动内容到正确文件"
        echo "   3. 备份保存在: $BACKUP_DIR"
    fi
    
    echo ""
done

echo "=== 重组完成 ==="
echo ""
echo "📝 注意事项："
echo "   - 当前实现为简化版，只做基本检查"
echo "   - 复杂的主语判断需要人工审查"
echo "   - 所有原始文件已备份"
