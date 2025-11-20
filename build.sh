#!/bin/bash
# =============================================================================
# BUILD SCRIPT FOR GTK CALCULATOR
# =============================================================================
# Author: khlaifiabilel
# Date: 2025-11-20
#
# This script handles building the GTK calculator on different platforms
# =============================================================================

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    echo -e "${2}${1}${NC}"
}

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        OS="windows"
    else
        OS="unknown"
    fi
    echo $OS
}

# Check if GTK3 is installed
check_gtk() {
    print_message "Checking for GTK3..." "$YELLOW"
    
    if pkg-config --exists gtk+-3.0; then
        print_message "✓ GTK3 found!" "$GREEN"
        GTK_VERSION=$(pkg-config --modversion gtk+-3.0)
        print_message "  Version: $GTK_VERSION" "$GREEN"
        return 0
    else
        print_message "✗ GTK3 not found!" "$RED"
        return 1
    fi
}

# Install GTK3 based on OS
install_gtk() {
    local OS=$1
    
    print_message "Installing GTK3 for $OS..." "$YELLOW"
    
    case $OS in
        linux)
            # Try to detect Linux distribution
            if [ -f /etc/debian_version ]; then
                print_message "Detected Debian/Ubuntu" "$YELLOW"
                sudo apt-get update
                sudo apt-get install -y libgtk-3-dev build-essential pkg-config
            elif [ -f /etc/redhat-release ]; then
                print_message "Detected RedHat/Fedora" "$YELLOW"
                sudo dnf install -y gtk3-devel gcc make pkg-config
            elif [ -f /etc/arch-release ]; then
                print_message "Detected Arch Linux" "$YELLOW"
                sudo pacman -S gtk3 base-devel pkg-config
            else
                print_message "Unknown Linux distribution" "$RED"
                print_message "Please install GTK3 development libraries manually" "$RED"
                exit 1
            fi
            ;;
            
        macos)
            if command -v brew &> /dev/null; then
                brew install gtk+3 pkg-config
            else
                print_message "Homebrew not found. Please install Homebrew first:" "$RED"
                print_message "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"" "$YELLOW"
                exit 1
            fi
            ;;
            
        windows)
            print_message "For Windows, please use MSYS2:" "$YELLOW"
            print_message "1. Install MSYS2 from https://www.msys2.org/" "$YELLOW"
            print_message "2. Run: pacman -S mingw-w64-x86_64-gtk3 mingw-w64-x86_64-toolchain" "$YELLOW"
            exit 1
            ;;
            
        *)
            print_message "Unknown operating system" "$RED"
            exit 1
            ;;
    esac
}

# Build the calculator
build_calculator() {
    print_message "\nBuilding GTK Calculator..." "$YELLOW"
    
    # Get GTK flags
    GTK_CFLAGS=$(pkg-config --cflags gtk+-3.0)
    GTK_LIBS=$(pkg-config --libs gtk+-3.0)
    
    # Compile command
    COMPILE_CMD="gcc -Wall -Wextra -g -O2 $GTK_CFLAGS calculator_gtk.c -o calculator_gtk $GTK_LIBS -lm"
    
    print_message "Compile command:" "$YELLOW"
    print_message "$COMPILE_CMD" "$NC"
    
    # Execute compilation
    if $COMPILE_CMD; then
        print_message "\n✓ Build successful!" "$GREEN"
        print_message "Executable created: calculator_gtk" "$GREEN"
        return 0
    else
        print_message "\n✗ Build failed!" "$RED"
        return 1
    fi
}

# Run the calculator
run_calculator() {
    if [ -f "./calculator_gtk" ]; then
        print_message "\nRunning calculator..." "$GREEN"
        ./calculator_gtk
    else
        print_message "Calculator executable not found. Build it first!" "$RED"
    fi
}

# Main script
main() {
    print_message "========================================" "$YELLOW"
    print_message "GTK Calculator Build Script" "$YELLOW"
    print_message "Author: khlaifiabilel" "$YELLOW"
    print_message "========================================" "$YELLOW"
    
    # Detect OS
    OS=$(detect_os)
    print_message "\nDetected OS: $OS" "$GREEN"
    
    # Check for GTK
    if ! check_gtk; then
        print_message "\nWould you like to install GTK3? (y/n)" "$YELLOW"
        read -r response
        if [[ "$response" == "y" ]] || [[ "$response" == "Y" ]]; then
            install_gtk $OS
            
            # Check again after installation
            if ! check_gtk; then
                print_message "GTK3 installation may have failed" "$RED"
                exit 1
            fi
        else
            print_message "GTK3 is required to build the calculator" "$RED"
            exit 1
        fi
    fi
    
    # Build calculator
    if build_calculator; then
        print_message "\nWould you like to run the calculator now? (y/n)" "$YELLOW"
        read -r response
        if [[ "$response" == "y" ]] || [[ "$response" == "Y" ]]; then
            run_calculator
        fi
    fi
}

# Check if script is run directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi