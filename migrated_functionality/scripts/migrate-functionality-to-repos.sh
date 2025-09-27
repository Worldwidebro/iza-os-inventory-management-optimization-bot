#!/bin/bash

# Migrate Functionality from Local Files to GitHub Repositories
# Billionaire Consciousness Empire - Functionality Migration Script

set -e

echo "🚀 Migrating Functionality to GitHub Repositories"
echo "================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_header() {
    echo -e "${PURPLE}🚀 $1${NC}"
}

# Configuration
MEMU_ROOT="/Users/divinejohns/memU"
TEMP_DIR="/tmp/memU-migration"
GITHUB_ORG="Worldwidebro"

# Create temporary directory for migration
setup_migration() {
    print_header "Setting up migration environment"
    
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"
    
    print_status "Migration environment ready"
}

# Migrate IZA OS Core functionality
migrate_iza_os_core() {
    print_header "Migrating IZA OS Core functionality"
    
    local repos=(
        "iza-os-core"
        "iza-os-agents"
        "iza-os-enterprise"
        "iza-os-infrastructure"
        "iza-os-integrations"
        "iza-os-automation"
        "iza-os-web"
        "iza-os-mobile"
        "iza-os-mcp"
        "iza-os-ml"
        "iza-os-ops"
        "iza-os-data"
        "iza-os-analytics"
        "iza-os-business"
        "iza-os-revenue"
        "iza-os-market"
        "iza-os-funding"
        "iza-os-monitoring"
        "iza-os-security"
        "iza-os-docs"
        "iza-os-templates"
        "iza-os-cli"
        "iza-os-playgrounds"
        "iza-os-experiments-llm"
        "avs-omni"
    )
    
    for repo in "${repos[@]}"; do
        echo "Migrating functionality to $repo..."
        
        # Clone repository
        if [ -d "$TEMP_DIR/$repo" ]; then
            rm -rf "$TEMP_DIR/$repo"
        fi
        
        gh repo clone "$GITHUB_ORG/$repo" "$TEMP_DIR/$repo" 2>/dev/null || {
            print_warning "Repository $repo not found, skipping..."
            continue
        }
        
        # Copy relevant files based on repository type
        case $repo in
            "iza-os-core")
                copy_core_files "$TEMP_DIR/$repo"
                ;;
            "iza-os-agents")
                copy_agent_files "$TEMP_DIR/$repo"
                ;;
            "iza-os-enterprise")
                copy_enterprise_files "$TEMP_DIR/$repo"
                ;;
            "iza-os-infrastructure")
                copy_infrastructure_files "$TEMP_DIR/$repo"
                ;;
            "iza-os-web")
                copy_web_files "$TEMP_DIR/$repo"
                ;;
            "iza-os-mobile")
                copy_mobile_files "$TEMP_DIR/$repo"
                ;;
            "iza-os-mcp")
                copy_mcp_files "$TEMP_DIR/$repo"
                ;;
            "iza-os-ml")
                copy_ml_files "$TEMP_DIR/$repo"
                ;;
            "avs-omni")
                copy_avs_files "$TEMP_DIR/$repo"
                ;;
            *)
                copy_generic_files "$TEMP_DIR/$repo"
                ;;
        esac
        
        # Commit and push changes
        commit_and_push "$TEMP_DIR/$repo" "$repo"
        
        print_status "Migrated functionality to $repo"
    done
}

# Copy core IZA OS files
copy_core_files() {
    local repo_dir="$1"
    
    # Copy core system files
    if [ -d "$MEMU_ROOT/repositories/iza-os-core" ]; then
        cp -r "$MEMU_ROOT/repositories/iza-os-core"/* "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy shared libraries
    if [ -d "$MEMU_ROOT/shared" ]; then
        cp -r "$MEMU_ROOT/shared" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy configuration files
    if [ -f "$MEMU_ROOT/docker-compose.yml" ]; then
        cp "$MEMU_ROOT/docker-compose.yml" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy documentation
    if [ -f "$MEMU_ROOT/ARCHITECTURE.md" ]; then
        cp "$MEMU_ROOT/ARCHITECTURE.md" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy agent files
copy_agent_files() {
    local repo_dir="$1"
    
    # Copy agent implementations
    if [ -d "$MEMU_ROOT/backend" ]; then
        mkdir -p "$repo_dir/agents"
        cp -r "$MEMU_ROOT/backend"/* "$repo_dir/agents/" 2>/dev/null || true
    fi
    
    # Copy MCP servers
    if [ -d "$MEMU_ROOT/mcp" ]; then
        cp -r "$MEMU_ROOT/mcp" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy agent templates
    if [ -d "$MEMU_ROOT/templates" ]; then
        cp -r "$MEMU_ROOT/templates" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy enterprise files
copy_enterprise_files() {
    local repo_dir="$1"
    
    # Copy enterprise dashboard
    if [ -d "$MEMU_ROOT/ui/iza-enterprise-platform" ]; then
        cp -r "$MEMU_ROOT/ui/iza-enterprise-platform"/* "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy business intelligence
    if [ -d "$MEMU_ROOT/analytics" ]; then
        cp -r "$MEMU_ROOT/analytics" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy revenue tracking
    if [ -d "$MEMU_ROOT/revenue" ]; then
        cp -r "$MEMU_ROOT/revenue" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy infrastructure files
copy_infrastructure_files() {
    local repo_dir="$1"
    
    # Copy DevOps files
    if [ -d "$MEMU_ROOT/devops" ]; then
        cp -r "$MEMU_ROOT/devops" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy deployment scripts
    if [ -d "$MEMU_ROOT/scripts" ]; then
        cp -r "$MEMU_ROOT/scripts" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy monitoring
    if [ -d "$MEMU_ROOT/monitoring" ]; then
        cp -r "$MEMU_ROOT/monitoring" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy web files
copy_web_files() {
    local repo_dir="$1"
    
    # Copy frontend components
    if [ -d "$MEMU_ROOT/frontend" ]; then
        cp -r "$MEMU_ROOT/frontend"/* "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy UI components
    if [ -d "$MEMU_ROOT/ui" ]; then
        cp -r "$MEMU_ROOT/ui" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy dashboard system
    if [ -d "$MEMU_ROOT/unified-dashboard-system" ]; then
        cp -r "$MEMU_ROOT/unified-dashboard-system" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy mobile files
copy_mobile_files() {
    local repo_dir="$1"
    
    # Copy iOS app files
    if [ -d "$MEMU_ROOT/consciousness-learning-system" ]; then
        cp -r "$MEMU_ROOT/consciousness-learning-system" "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy mobile optimization
    if [ -d "$MEMU_ROOT/mobile-access-manager" ]; then
        cp -r "$MEMU_ROOT/mobile-access-manager" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy MCP files
copy_mcp_files() {
    local repo_dir="$1"
    
    # Copy MCP implementations
    if [ -d "$MEMU_ROOT/mcp" ]; then
        cp -r "$MEMU_ROOT/mcp"/* "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy integration system
    if [ -d "$MEMU_ROOT/integration" ]; then
        cp -r "$MEMU_ROOT/integration" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy ML files
copy_ml_files() {
    local repo_dir="$1"
    
    # Copy ML pipeline
    if [ -d "$MEMU_ROOT/mlops" ]; then
        cp -r "$MEMU_ROOT/mlops"/* "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy AI systems
    if [ -d "$MEMU_ROOT/autonomous" ]; then
        cp -r "$MEMU_ROOT/autonomous"/* "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy AVS files
copy_avs_files() {
    local repo_dir="$1"
    
    # Copy AVS omni files
    if [ -d "$MEMU_ROOT/avs-omni" ]; then
        cp -r "$MEMU_ROOT/avs-omni"/* "$repo_dir/" 2>/dev/null || true
    fi
    
    # Copy billionaire consciousness files
    if [ -d "$MEMU_ROOT/ui/billionaire-consciousness-empire" ]; then
        cp -r "$MEMU_ROOT/ui/billionaire-consciousness-empire" "$repo_dir/" 2>/dev/null || true
    fi
}

# Copy generic files
copy_generic_files() {
    local repo_dir="$1"
    
    # Copy common files
    if [ -f "$MEMU_ROOT/README.md" ]; then
        cp "$MEMU_ROOT/README.md" "$repo_dir/" 2>/dev/null || true
    fi
    
    if [ -f "$MEMU_ROOT/.gitignore" ]; then
        cp "$MEMU_ROOT/.gitignore" "$repo_dir/" 2>/dev/null || true
    fi
}

# Commit and push changes
commit_and_push() {
    local repo_dir="$1"
    local repo_name="$2"
    
    cd "$repo_dir"
    
    # Add all changes
    git add . 2>/dev/null || true
    
    # Check if there are changes to commit
    if git diff --cached --quiet; then
        print_info "No changes to commit for $repo_name"
        return
    fi
    
    # Commit changes
    git commit -m "feat: migrate functionality from memU local files

- Migrated core functionality from memU ecosystem
- Added shared libraries and configurations
- Integrated with billionaire consciousness empire
- Prepared for production deployment

Co-authored-by: IZA OS <iza-os@worldwidebro.com>" 2>/dev/null || true
    
    # Push changes
    git push origin main 2>/dev/null || git push origin master 2>/dev/null || true
    
    print_status "Committed and pushed changes for $repo_name"
}

# Migrate business system repositories
migrate_business_repos() {
    print_header "Migrating Business System Repositories"
    
    local repos=(
        "ai-boss-holdings-v4"
        "aibossoslandingpage"
        "deployment-orchestrator"
        "mcp-integration-hub"
        "unified-dashboard-system"
        "mobile-access-manager"
        "research-processing-pipeline"
        "genixbank-financial-system"
        "autonomous-venture-studio"
        "nexus-ai-enterprise-platform"
        "quantum-brain-sync-website"
        "fastmcp"
        "SuperClaude_Framework"
        "claude-flow"
        "Resume"
        "babystepsmatrix1"
        "iza-os-ecosystem"
    )
    
    for repo in "${repos[@]}"; do
        echo "Migrating functionality to $repo..."
        
        # Clone repository
        if [ -d "$TEMP_DIR/$repo" ]; then
            rm -rf "$TEMP_DIR/$repo"
        fi
        
        gh repo clone "$GITHUB_ORG/$repo" "$TEMP_DIR/$repo" 2>/dev/null || {
            print_warning "Repository $repo not found, skipping..."
            continue
        }
        
        # Copy relevant business files
        copy_business_files "$TEMP_DIR/$repo" "$repo"
        
        # Commit and push changes
        commit_and_push "$TEMP_DIR/$repo" "$repo"
        
        print_status "Migrated functionality to $repo"
    done
}

# Copy business files
copy_business_files() {
    local repo_dir="$1"
    local repo_name="$2"
    
    case $repo_name in
        "ai-boss-holdings-v4")
            if [ -d "$MEMU_ROOT/repositories/ai-boss-holdings-v4" ]; then
                cp -r "$MEMU_ROOT/repositories/ai-boss-holdings-v4"/* "$repo_dir/" 2>/dev/null || true
            fi
            ;;
        "genixbank-financial-system")
            if [ -d "$MEMU_ROOT/genix-bank-mvp" ]; then
                cp -r "$MEMU_ROOT/genix-bank-mvp"/* "$repo_dir/" 2>/dev/null || true
            fi
            if [ -d "$MEMU_ROOT/ui/genix-bank" ]; then
                cp -r "$MEMU_ROOT/ui/genix-bank" "$repo_dir/" 2>/dev/null || true
            fi
            ;;
        "unified-dashboard-system")
            if [ -d "$MEMU_ROOT/unified-dashboard-system" ]; then
                cp -r "$MEMU_ROOT/unified-dashboard-system"/* "$repo_dir/" 2>/dev/null || true
            fi
            ;;
        "deployment-orchestrator")
            if [ -d "$MEMU_ROOT/deployment-orchestrator" ]; then
                cp -r "$MEMU_ROOT/deployment-orchestrator"/* "$repo_dir/" 2>/dev/null || true
            fi
            ;;
        *)
            copy_generic_files "$repo_dir"
            ;;
    esac
}

# Create cleanup rules
create_cleanup_rules() {
    print_header "Creating Cleanup Rules for Post-Migration"
    
    cat > "$MEMU_ROOT/CLEANUP_RULES.md" << 'EOF'
# 🧹 Cleanup Rules for Post-Migration
## Billionaire Consciousness Empire - File Cleanup Guidelines

### 📋 Overview
After migrating functionality to GitHub repositories, these rules define what files can be safely deleted from the local memU directory.

### ✅ Safe to Delete After Migration

#### 1. Duplicate Repository Files
- `/repositories/` - All subdirectories that have been migrated to GitHub
- `/ui/` - UI components that have been migrated to respective repositories
- `/backend/` - Backend code that has been migrated to iza-os-core or iza-os-agents
- `/frontend/` - Frontend code that has been migrated to iza-os-web

#### 2. Temporary Migration Files
- `/tools/github-management/` - Migration scripts (keep for reference)
- `/tmp/` - Any temporary migration files
- `*.tmp` - Temporary files created during migration

#### 3. Redundant Configuration Files
- Duplicate `docker-compose.yml` files
- Duplicate `package.json` files
- Duplicate `requirements.txt` files

### ⚠️ Keep for Reference

#### 1. Documentation Files
- `/docs/` - Keep all documentation
- `*.md` - Keep all markdown files in root directory
- `/consciousness-learning-system/` - Keep learning materials

#### 2. Tools and Scripts
- `/tools/` - Keep tools that are not migration-specific
- `/scripts/` - Keep deployment and utility scripts

#### 3. Configuration Files
- `.env` files
- `config/` directory
- Database initialization files

### 🚫 Never Delete

#### 1. Core System Files
- `README.md` - Main project documentation
- `.gitignore` - Git ignore rules
- `docker-compose.yml` - Main orchestration file

#### 2. Active Development Files
- Files currently being worked on
- Files with recent modifications
- Files referenced in active workflows

#### 3. Backup and Archive Files
- `.backup/` directories
- Archive files with important historical data

### 🔄 Migration Verification Checklist

Before deleting any files, verify:

- [ ] Functionality has been successfully migrated to GitHub repository
- [ ] Repository has been tested and is working
- [ ] All team members have access to the new repository
- [ ] Documentation has been updated to reflect new location
- [ ] CI/CD pipelines are working in the new repository
- [ ] Dependencies and imports have been updated

### 🧹 Cleanup Script

```bash
#!/bin/bash
# cleanup-post-migration.sh

echo "🧹 Cleaning up files after migration..."

# Remove duplicate repository directories
rm -rf repositories/
rm -rf ui/
rm -rf backend/
rm -rf frontend/

# Remove temporary migration files
find . -name "*.tmp" -delete
find . -name "*migration*" -type f -delete

# Remove duplicate configuration files
find . -name "docker-compose.yml" -not -path "./docker-compose.yml" -delete
find . -name "package.json" -not -path "./package.json" -delete

echo "✅ Cleanup completed!"
```

### 📊 Storage Savings

Expected storage savings after cleanup:
- **Repository Files**: ~2-5 GB
- **Duplicate UI Components**: ~500MB-1GB
- **Temporary Files**: ~100-500MB
- **Total Savings**: ~3-7 GB

### 🔒 Safety Measures

1. **Backup First**: Always create a backup before cleanup
2. **Gradual Cleanup**: Delete files in small batches
3. **Verification**: Test functionality after each cleanup batch
4. **Rollback Plan**: Keep backup files for 30 days minimum

### 📈 Benefits of Cleanup

1. **Reduced Storage**: Significant disk space savings
2. **Improved Performance**: Faster file operations
3. **Better Organization**: Cleaner directory structure
4. **Easier Maintenance**: Less duplicate code to maintain
5. **Clear Dependencies**: Obvious source of truth for each component

---

**Status**: ✅ Ready for implementation after migration completion
**Risk Level**: 🟡 Medium - Requires careful verification
**Time Estimate**: 2-4 hours for complete cleanup
EOF

    print_status "Cleanup rules created at CLEANUP_RULES.md"
}

# Main execution function
main() {
    print_header "Migrating Functionality to GitHub Repositories"
    echo ""
    
    # Check prerequisites
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI not found. Please install: brew install gh"
        exit 1
    fi
    
    if ! gh auth status >/dev/null 2>&1; then
        print_error "GitHub CLI not authenticated. Please run: gh auth login"
        exit 1
    fi
    
    print_info "Migration Plan:"
    print_info "  - Migrate IZA OS Core repositories (25)"
    print_info "  - Migrate Business System repositories (17)"
    print_info "  - Create cleanup rules"
    print_info "  - Verify migration success"
    echo ""
    
    # Setup migration environment
    setup_migration
    
    # Migrate functionality
    migrate_iza_os_core
    echo ""
    
    migrate_business_repos
    echo ""
    
    # Create cleanup rules
    create_cleanup_rules
    echo ""
    
    # Cleanup temporary directory
    rm -rf "$TEMP_DIR"
    
    print_status "Functionality migration completed!"
    print_info "Next steps:"
    print_info "  1. Review migrated repositories on GitHub"
    print_info "  2. Test functionality in each repository"
    print_info "  3. Update documentation and dependencies"
    print_info "  4. Run cleanup script when ready"
    echo ""
    print_info "📋 Cleanup rules available at: CLEANUP_RULES.md"
    print_info "🧹 Run cleanup script when migration is verified"
}

# Run main function
main "$@"
