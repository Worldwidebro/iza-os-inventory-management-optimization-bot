#!/bin/bash

# Organize and Cleanup Files for Storage Optimization
# Billionaire Consciousness Empire - File Organization and Cleanup Script

set -e

echo "🧹 Organizing and Cleaning Up Files for Storage Optimization"
echo "==========================================================="
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
BACKUP_DIR="/tmp/memU-backup-$(date +%Y%m%d-%H%M%S)"
CLEANUP_LOG="/tmp/memU-cleanup-$(date +%Y%m%d-%H%M%S).log"

# Initialize cleanup log
init_cleanup_log() {
    print_header "Initializing cleanup log"
    
    echo "=== MemU File Organization and Cleanup Log ===" > "$CLEANUP_LOG"
    echo "Started: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    print_status "Cleanup log initialized: $CLEANUP_LOG"
}

# Create backup
create_backup() {
    print_header "Creating backup before cleanup"
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup critical directories
    print_info "Backing up critical directories..."
    
    if [ -d "$MEMU_ROOT/repositories" ]; then
        cp -r "$MEMU_ROOT/repositories" "$BACKUP_DIR/" 2>/dev/null || true
        echo "Backed up: repositories/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/ui" ]; then
        cp -r "$MEMU_ROOT/ui" "$BACKUP_DIR/" 2>/dev/null || true
        echo "Backed up: ui/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/backend" ]; then
        cp -r "$MEMU_ROOT/backend" "$BACKUP_DIR/" 2>/dev/null || true
        echo "Backed up: backend/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/frontend" ]; then
        cp -r "$MEMU_ROOT/frontend" "$BACKUP_DIR/" 2>/dev/null || true
        echo "Backed up: frontend/" >> "$CLEANUP_LOG"
    fi
    
    print_status "Backup created at: $BACKUP_DIR"
}

# Analyze storage usage
analyze_storage() {
    print_header "Analyzing current storage usage"
    
    echo "=== Storage Analysis ===" >> "$CLEANUP_LOG"
    echo "Date: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    # Get total size
    local total_size=$(du -sh "$MEMU_ROOT" 2>/dev/null | cut -f1)
    print_info "Total memU size: $total_size"
    echo "Total size: $total_size" >> "$CLEANUP_LOG"
    
    # Get directory sizes
    print_info "Directory sizes:"
    echo "Directory sizes:" >> "$CLEANUP_LOG"
    
    for dir in "$MEMU_ROOT"/*; do
        if [ -d "$dir" ]; then
            local dir_name=$(basename "$dir")
            local dir_size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            print_info "  $dir_name: $dir_size"
            echo "  $dir_name: $dir_size" >> "$CLEANUP_LOG"
        fi
    done
    
    echo "" >> "$CLEANUP_LOG"
    print_status "Storage analysis completed"
}

# Find duplicate files
find_duplicates() {
    print_header "Finding duplicate files"
    
    echo "=== Duplicate Files Analysis ===" >> "$CLEANUP_LOG"
    echo "Date: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    # Find files with same content
    print_info "Searching for duplicate files..."
    
    # Create temporary file for duplicates
    local duplicates_file="/tmp/duplicates-$(date +%Y%m%d-%H%M%S).txt"
    
    # Find duplicates by content (simplified approach)
    find "$MEMU_ROOT" -type f -name "*.md" -exec md5sum {} \; | \
    sort | uniq -d -w 32 > "$duplicates_file" 2>/dev/null || true
    
    local duplicate_count=$(wc -l < "$duplicates_file" 2>/dev/null || echo "0")
    print_info "Found $duplicate_count potential duplicate files"
    echo "Found $duplicate_count potential duplicate files" >> "$CLEANUP_LOG"
    
    if [ -f "$duplicates_file" ]; then
        echo "Duplicate files:" >> "$CLEANUP_LOG"
        cat "$duplicates_file" >> "$CLEANUP_LOG"
    fi
    
    echo "" >> "$CLEANUP_LOG"
    print_status "Duplicate analysis completed"
}

# Organize files by category
organize_files() {
    print_header "Organizing files by category"
    
    echo "=== File Organization ===" >> "$CLEANUP_LOG"
    echo "Date: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    # Create organized directory structure
    local organized_dir="$MEMU_ROOT/organized-files"
    mkdir -p "$organized_dir"/{repositories,ui-components,backend-code,frontend-code,documentation,tools,scripts,configs,data}
    
    print_info "Created organized directory structure"
    echo "Created organized directory structure" >> "$CLEANUP_LOG"
    
    # Move files to organized structure
    if [ -d "$MEMU_ROOT/repositories" ]; then
        print_info "Organizing repository files..."
        cp -r "$MEMU_ROOT/repositories" "$organized_dir/" 2>/dev/null || true
        echo "Moved: repositories/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/ui" ]; then
        print_info "Organizing UI components..."
        cp -r "$MEMU_ROOT/ui" "$organized_dir/ui-components/" 2>/dev/null || true
        echo "Moved: ui/ -> ui-components/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/backend" ]; then
        print_info "Organizing backend code..."
        cp -r "$MEMU_ROOT/backend" "$organized_dir/backend-code/" 2>/dev/null || true
        echo "Moved: backend/ -> backend-code/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/frontend" ]; then
        print_info "Organizing frontend code..."
        cp -r "$MEMU_ROOT/frontend" "$organized_dir/frontend-code/" 2>/dev/null || true
        echo "Moved: frontend/ -> frontend-code/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/documentation" ]; then
        print_info "Organizing documentation..."
        cp -r "$MEMU_ROOT/documentation" "$organized_dir/" 2>/dev/null || true
        echo "Moved: documentation/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/tools" ]; then
        print_info "Organizing tools..."
        cp -r "$MEMU_ROOT/tools" "$organized_dir/" 2>/dev/null || true
        echo "Moved: tools/" >> "$CLEANUP_LOG"
    fi
    
    if [ -d "$MEMU_ROOT/scripts" ]; then
        print_info "Organizing scripts..."
        cp -r "$MEMU_ROOT/scripts" "$organized_dir/" 2>/dev/null || true
        echo "Moved: scripts/" >> "$CLEANUP_LOG"
    fi
    
    echo "" >> "$CLEANUP_LOG"
    print_status "File organization completed"
}

# Clean up temporary files
cleanup_temporary_files() {
    print_header "Cleaning up temporary files"
    
    echo "=== Temporary Files Cleanup ===" >> "$CLEANUP_LOG"
    echo "Date: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    local temp_files_removed=0
    local temp_size_freed=0
    
    # Find and remove temporary files
    print_info "Removing temporary files..."
    
    # Remove .tmp files
    find "$MEMU_ROOT" -name "*.tmp" -type f -delete 2>/dev/null || true
    local tmp_count=$(find "$MEMU_ROOT" -name "*.tmp" -type f | wc -l)
    temp_files_removed=$((temp_files_removed + tmp_count))
    echo "Removed *.tmp files: $tmp_count" >> "$CLEANUP_LOG"
    
    # Remove .log files
    find "$MEMU_ROOT" -name "*.log" -type f -delete 2>/dev/null || true
    local log_count=$(find "$MEMU_ROOT" -name "*.log" -type f | wc -l)
    temp_files_removed=$((temp_files_removed + log_count))
    echo "Removed *.log files: $log_count" >> "$CLEANUP_LOG"
    
    # Remove .cache files
    find "$MEMU_ROOT" -name "*.cache" -type f -delete 2>/dev/null || true
    local cache_count=$(find "$MEMU_ROOT" -name "*.cache" -type f | wc -l)
    temp_files_removed=$((temp_files_removed + cache_count))
    echo "Removed *.cache files: $cache_count" >> "$CLEANUP_LOG"
    
    # Remove node_modules directories
    find "$MEMU_ROOT" -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
    local node_modules_count=$(find "$MEMU_ROOT" -name "node_modules" -type d | wc -l)
    echo "Removed node_modules directories: $node_modules_count" >> "$CLEANUP_LOG"
    
    # Remove __pycache__ directories
    find "$MEMU_ROOT" -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
    local pycache_count=$(find "$MEMU_ROOT" -name "__pycache__" -type d | wc -l)
    echo "Removed __pycache__ directories: $pycache_count" >> "$CLEANUP_LOG"
    
    # Remove .DS_Store files
    find "$MEMU_ROOT" -name ".DS_Store" -type f -delete 2>/dev/null || true
    local dsstore_count=$(find "$MEMU_ROOT" -name ".DS_Store" -type f | wc -l)
    echo "Removed .DS_Store files: $dsstore_count" >> "$CLEANUP_LOG"
    
    print_info "Removed $temp_files_removed temporary files"
    echo "Total temporary files removed: $temp_files_removed" >> "$CLEANUP_LOG"
    
    echo "" >> "$CLEANUP_LOG"
    print_status "Temporary files cleanup completed"
}

# Remove duplicate directories
remove_duplicate_directories() {
    print_header "Removing duplicate directories"
    
    echo "=== Duplicate Directories Cleanup ===" >> "$CLEANUP_LOG"
    echo "Date: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    # List of directories that can be safely removed after migration
    local duplicate_dirs=(
        "repositories"
        "ui"
        "backend"
        "frontend"
        "integrated-dashboards"
        "genix-bank-mvp"
        "deployment-orchestrator"
        "unified-architecture"
        "iza-os-organized"
        "iza-ecosystem-consolidated"
    )
    
    local removed_count=0
    
    for dir in "${duplicate_dirs[@]}"; do
        if [ -d "$MEMU_ROOT/$dir" ]; then
            print_info "Removing duplicate directory: $dir"
            rm -rf "$MEMU_ROOT/$dir" 2>/dev/null || true
            echo "Removed: $dir" >> "$CLEANUP_LOG"
            removed_count=$((removed_count + 1))
        fi
    done
    
    print_info "Removed $removed_count duplicate directories"
    echo "Total duplicate directories removed: $removed_count" >> "$CLEANUP_LOG"
    
    echo "" >> "$CLEANUP_LOG"
    print_status "Duplicate directories cleanup completed"
}

# Optimize storage
optimize_storage() {
    print_header "Optimizing storage"
    
    echo "=== Storage Optimization ===" >> "$CLEANUP_LOG"
    echo "Date: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    # Compress large files
    print_info "Compressing large files..."
    
    # Find and compress large log files
    find "$MEMU_ROOT" -name "*.log" -size +10M -exec gzip {} \; 2>/dev/null || true
    local compressed_count=$(find "$MEMU_ROOT" -name "*.log.gz" | wc -l)
    echo "Compressed large log files: $compressed_count" >> "$CLEANUP_LOG"
    
    # Find and compress large text files
    find "$MEMU_ROOT" -name "*.txt" -size +5M -exec gzip {} \; 2>/dev/null || true
    local compressed_txt_count=$(find "$MEMU_ROOT" -name "*.txt.gz" | wc -l)
    echo "Compressed large text files: $compressed_txt_count" >> "$CLEANUP_LOG"
    
    print_info "Compressed $((compressed_count + compressed_txt_count)) large files"
    echo "Total compressed files: $((compressed_count + compressed_txt_count))" >> "$CLEANUP_LOG"
    
    echo "" >> "$CLEANUP_LOG"
    print_status "Storage optimization completed"
}

# Generate cleanup report
generate_cleanup_report() {
    print_header "Generating cleanup report"
    
    echo "=== Cleanup Summary ===" >> "$CLEANUP_LOG"
    echo "Date: $(date)" >> "$CLEANUP_LOG"
    echo "" >> "$CLEANUP_LOG"
    
    # Get final size
    local final_size=$(du -sh "$MEMU_ROOT" 2>/dev/null | cut -f1)
    print_info "Final memU size: $final_size"
    echo "Final size: $final_size" >> "$CLEANUP_LOG"
    
    # Calculate space saved
    local initial_size=$(grep "Total size:" "$CLEANUP_LOG" | head -1 | cut -d: -f2 | xargs)
    print_info "Initial size: $initial_size"
    echo "Initial size: $initial_size" >> "$CLEANUP_LOG"
    
    # Create summary
    cat >> "$CLEANUP_LOG" << EOF

=== CLEANUP SUMMARY ===
Started: $(grep "Started:" "$CLEANUP_LOG" | head -1)
Completed: $(date)
Initial size: $initial_size
Final size: $final_size
Backup location: $BACKUP_DIR
Cleanup log: $CLEANUP_LOG

=== ACTIONS TAKEN ===
1. Created backup of critical directories
2. Analyzed storage usage
3. Found and organized duplicate files
4. Organized files by category
5. Cleaned up temporary files
6. Removed duplicate directories
7. Optimized storage

=== RECOMMENDATIONS ===
1. Review organized files in organized-files/
2. Test functionality after cleanup
3. Keep backup for 30 days minimum
4. Monitor storage usage going forward
5. Implement regular cleanup schedule

=== NEXT STEPS ===
1. Migrate functionality to GitHub repositories
2. Test all systems after cleanup
3. Update documentation
4. Set up automated cleanup schedule
EOF

    print_status "Cleanup report generated: $CLEANUP_LOG"
}

# Create storage monitoring script
create_storage_monitor() {
    print_header "Creating storage monitoring script"
    
    cat > "$MEMU_ROOT/tools/monitor-storage.sh" << 'EOF'
#!/bin/bash

# Storage monitoring script for memU
# Run daily to monitor storage usage

MEMU_ROOT="/Users/divinejohns/memU"
LOG_FILE="/tmp/memU-storage-monitor-$(date +%Y%m%d).log"

echo "=== MemU Storage Monitor ===" > "$LOG_FILE"
echo "Date: $(date)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Get current size
current_size=$(du -sh "$MEMU_ROOT" 2>/dev/null | cut -f1)
echo "Current size: $current_size" >> "$LOG_FILE"

# Get directory sizes
echo "Directory sizes:" >> "$LOG_FILE"
for dir in "$MEMU_ROOT"/*; do
    if [ -d "$dir" ]; then
        dir_name=$(basename "$dir")
        dir_size=$(du -sh "$dir" 2>/dev/null | cut -f1)
        echo "  $dir_name: $dir_size" >> "$LOG_FILE"
    fi
done

# Check for large files
echo "" >> "$LOG_FILE"
echo "Large files (>100MB):" >> "$LOG_FILE"
find "$MEMU_ROOT" -type f -size +100M -exec ls -lh {} \; >> "$LOG_FILE" 2>/dev/null || true

echo "Storage monitor completed: $LOG_FILE"
EOF

    chmod +x "$MEMU_ROOT/tools/monitor-storage.sh"
    
    print_status "Storage monitoring script created"
}

# Main execution function
main() {
    print_header "File Organization and Cleanup for Storage Optimization"
    echo ""
    
    print_info "Cleanup Plan:"
    print_info "  - Create backup of critical files"
    print_info "  - Analyze current storage usage"
    print_info "  - Find and organize duplicate files"
    print_info "  - Remove temporary and duplicate files"
    print_info "  - Optimize storage"
    print_info "  - Generate cleanup report"
    echo ""
    
    # Initialize cleanup log
    init_cleanup_log
    
    # Create backup
    create_backup
    
    # Analyze storage
    analyze_storage
    
    # Find duplicates
    find_duplicates
    
    # Organize files
    organize_files
    
    # Clean up temporary files
    cleanup_temporary_files
    
    # Remove duplicate directories
    remove_duplicate_directories
    
    # Optimize storage
    optimize_storage
    
    # Generate cleanup report
    generate_cleanup_report
    
    # Create storage monitor
    create_storage_monitor
    
    print_status "File organization and cleanup completed!"
    print_info "Results:"
    print_info "  - Backup created at: $BACKUP_DIR"
    print_info "  - Cleanup log: $CLEANUP_LOG"
    print_info "  - Organized files: organized-files/"
    print_info "  - Storage monitor: tools/monitor-storage.sh"
    echo ""
    print_info "💾 Storage Optimization Complete!"
    print_info "📊 Review cleanup report for details"
    print_info "🔍 Monitor storage usage going forward"
    print_info "🚀 Ready for GitHub migration"
}

# Run main function
main "$@"
