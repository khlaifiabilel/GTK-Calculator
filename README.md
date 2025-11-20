# GTK Calculator

A modern, graphical calculator application built with GTK3 and C.

![GTK Calculator](calculator_screenshot.png)

## Features

- **Basic Operations**: Addition, Subtraction, Multiplication, Division
- **Memory Functions**: Store, Recall, Clear
- **Additional Functions**: Percentage, Sign change, Backspace
- **Professional UI**: Modern design with CSS styling
- **Keyboard Support**: Use your keyboard for input
- **Error Handling**: Division by zero protection

## Requirements

- GTK3 development libraries
- GCC compiler
- pkg-config
- Make (optional, for using Makefile)

## Quick Start

### Ubuntu/Debian
```bash
# Install dependencies
sudo apt-get update
sudo apt-get install libgtk-3-dev build-essential

# Build and run
make run
```

### macOS
```bash
# Install dependencies
brew install gtk+3 pkg-config

# Build and run
make run
```

### Using Build Script
```bash
# Make script executable
chmod +x build.sh

# Run build script
./build.sh
```

## Building Manually

```bash
gcc `pkg-config --cflags gtk+-3.0` calculator_gtk.c -o calculator_gtk `pkg-config --libs gtk+-3.0` -lm
./calculator_gtk
```

## Usage

1. **Number Entry**: Click number buttons or use keyboard
2. **Operations**: Click operator buttons (+, -, ×, ÷)
3. **Calculate**: Press = or Enter key
4. **Clear**: C clears all, CE clears current entry
5. **Memory**: MS stores, MR recalls, MC clears memory

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| 0-9 | Enter numbers |
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| Enter | Calculate |
| Escape | Clear |
| Backspace | Delete last digit |
| . | Decimal point |

## Project Structure

```
gtk-calculator/
├── calculator_gtk.c      # Main source code
├── Makefile             # Build automation
├── build.sh             # Build script
├── README.md            # This file
└── GTK_CALCULATOR_DOCUMENTATION.md  # Detailed documentation
```

## Contributing

Feel free to fork, modify, and submit pull requests!

## Learning Resources

- [GTK Documentation](https://docs.gtk.org/)
- [C Programming](https://en.cppreference.com/)
- See `GTK_CALCULATOR_DOCUMENTATION.md` for detailed explanations

## License

This project is created for educational purposes.

## Author

**khlaifiabilel**  
Date: 2025-11-20

---
*Happy Calculating!* 🧮