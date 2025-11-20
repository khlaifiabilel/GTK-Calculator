# GTK Calculator - Complete GUI Documentation

## Table of Contents
1. [Introduction to GTK](#introduction-to-gtk)
2. [Installation Guide](#installation-guide)
3. [Code Structure Overview](#code-structure-overview)
4. [GTK Concepts Explained](#gtk-concepts-explained)
5. [Event-Driven Programming](#event-driven-programming)
6. [Widgets Used](#widgets-used)
7. [CSS Styling in GTK](#css-styling-in-gtk)
8. [Compilation and Running](#compilation-and-running)
9. [Troubleshooting](#troubleshooting)
10. [Extending the Calculator](#extending-the-calculator)

## Introduction to GTK

### What is GTK?
GTK (GIMP Toolkit) is a multi-platform toolkit for creating graphical user interfaces. Originally developed for GIMP (GNU Image Manipulation Program), it's now used by many applications.

### Key Features:
- **Cross-platform**: Works on Linux, Windows, macOS
- **Widget-based**: Uses pre-built components (buttons, labels, etc.)
- **Event-driven**: Responds to user interactions
- **CSS styling**: Modern theming capabilities

## Installation Guide

### Ubuntu/Debian
```bash
# Update package list
sudo apt-get update

# Install GTK3 development libraries
sudo apt-get install libgtk-3-dev

# Install build tools
sudo apt-get install build-essential pkg-config
```

### Fedora/RedHat
```bash
sudo dnf install gtk3-devel
sudo dnf install gcc make pkg-config
```

### macOS (using Homebrew)
```bash
brew install gtk+3
brew install pkg-config
```

### Windows (using MSYS2)
```bash
pacman -S mingw-w64-x86_64-gtk3
pacman -S mingw-w64-x86_64-toolchain
```

## Code Structure Overview

```
calculator_gtk.c
│
├── Headers & Includes
│   ├── gtk/gtk.h     - GTK library
│   ├── string.h      - String operations
│   ├── stdlib.h      - Standard library
│   └── math.h        - Mathematical functions
│
├── Global Variables
│   ├── GUI Components (widgets)
│   ├── Calculator State
│   └── CSS Style String
│
├── Function Prototypes
│   ├── Event Handlers
│   └── Utility Functions
│
├── Main Function
│   ├── GTK Initialization
│   ├── Window Creation
│   ├── Widget Layout
│   ├── Event Connections
│   └── Main Loop
│
├── Callback Functions
│   ├── Number handlers
│   ├── Operator handlers
│   ├── Special function handlers
│   └── Memory handlers
│
└── Utility Functions
    ├── Display updates
    ├── Calculations
    └── CSS application
```

## GTK Concepts Explained

### 1. Widgets
Widgets are the building blocks of GTK applications:

```c
// Creating a button widget
GtkWidget *button = gtk_button_new_with_label("Click Me");

// Creating a window widget
GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
```

### 2. Containers
Containers organize widgets:

```c
// Grid container - arranges widgets in rows/columns
GtkWidget *grid = gtk_grid_new();

// Box container - arranges widgets horizontally/vertically
GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
```

### 3. Signals and Callbacks
GTK uses signals to handle events:

```c
// Connect a callback to a button click
g_signal_connect(button, "clicked", G_CALLBACK(on_button_clicked), data);

// Callback function signature
void on_button_clicked(GtkWidget *widget, gpointer data) {
    // Handle the click
}
```

## Event-Driven Programming

### The Main Loop
```c
gtk_main();  // Starts the event loop
```

The main loop:
1. Waits for events (clicks, key presses, etc.)
2. Dispatches events to appropriate handlers
3. Updates the display
4. Repeats until `gtk_main_quit()` is called

### Event Flow Diagram
```
User Action (Click)
    ↓
GTK Detects Event
    ↓
Signal Emitted
    ↓
Callback Function Called
    ↓
UI Updated
    ↓
Wait for Next Event
```

## Widgets Used

### 1. GtkWindow
**Purpose**: Main application window
```c
GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
gtk_window_set_title(GTK_WINDOW(window), "Title");
gtk_window_set_default_size(GTK_WINDOW(window), width, height);
```

### 2. GtkGrid
**Purpose**: Layout container
```c
GtkWidget *grid = gtk_grid_new();
gtk_grid_attach(GTK_GRID(grid), widget, column, row, width, height);
gtk_grid_set_row_spacing(GTK_GRID(grid), pixels);
```

### 3. GtkEntry
**Purpose**: Text input/display
```c
GtkWidget *entry = gtk_entry_new();
gtk_entry_set_text(GTK_ENTRY(entry), "text");
const gchar *text = gtk_entry_get_text(GTK_ENTRY(entry));
```

### 4. GtkButton
**Purpose**: Clickable buttons
```c
GtkWidget *button = gtk_button_new_with_label("Label");
g_signal_connect(button, "clicked", G_CALLBACK(handler), NULL);
```

### 5. GtkLabel
**Purpose**: Display text
```c
GtkWidget *label = gtk_label_new("Text");
gtk_label_set_text(GTK_LABEL(label), "New Text");
```

## CSS Styling in GTK

### Applying CSS
```c
// Create CSS provider
GtkCssProvider *provider = gtk_css_provider_new();

// Load CSS from string
gtk_css_provider_load_from_data(provider, css_string, -1, NULL);

// Apply to screen
gtk_style_context_add_provider_for_screen(screen,
    GTK_STYLE_PROVIDER(provider),
    GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
```

### CSS Syntax for GTK
```css
/* Widget by name */
#display {
    font-size: 24px;
}

/* Widget by class */
.button-number {
    background-color: #4a4a4a;
    color: white;
}

/* Pseudo-classes */
.button-number:hover {
    background-color: #5a5a5a;
}
```

## Compilation and Running

### Using gcc directly
```bash
# Compile
gcc `pkg-config --cflags gtk+-3.0` calculator_gtk.c -o calculator_gtk `pkg-config --libs gtk+-3.0` -lm

# Run
./calculator_gtk
```

### Using the Makefile
```bash
# Build
make

# Build and run
make run

# Clean build files
make clean
```

### Understanding pkg-config
`pkg-config` provides compiler and linker flags:
```bash
# Show compile flags
pkg-config --cflags gtk+-3.0

# Show linker flags
pkg-config --libs gtk+-3.0
```

## Troubleshooting

### Common Issues and Solutions

#### 1. GTK not found
**Error**: `Package gtk+-3.0 was not found`
**Solution**: Install GTK3 development libraries

#### 2. Undefined reference errors
**Error**: `undefined reference to 'gtk_init'`
**Solution**: Ensure GTK libraries are linked properly

#### 3. Segmentation fault
**Possible causes**:
- Accessing NULL pointers
- Wrong widget casting
- Missing gtk_init()

**Debugging**:
```bash
# Run with gdb debugger
gdb ./calculator_gtk
(gdb) run
(gdb) backtrace  # After crash
```

#### 4. CSS not applying
**Check**:
- CSS syntax is valid
- Widget names/classes are set correctly
- CSS provider is properly connected

## Extending the Calculator

### 1. Add Scientific Functions
```c
// Add buttons for sin, cos, tan, log, etc.
void on_sin_clicked(GtkWidget *button, gpointer data) {
    const gchar *current = gtk_entry_get_text(GTK_ENTRY(display_entry));
    double value = atof(current);
    double result = sin(value * M_PI / 180.0);  // Convert to radians
    
    char text[256];
    snprintf(text, sizeof(text), "%g", result);
    update_display(text);
}
```

### 2. Add Keyboard Support
```c
// Connect key-press event to window
g_signal_connect(window, "key-press-event", G_CALLBACK(on_key_press), NULL);

// Handle key presses
gboolean on_key_press(GtkWidget *widget, GdkEventKey *event, gpointer data) {
    switch (event->keyval) {
        case GDK_KEY_0:
        case GDK_KEY_KP_0:
            // Handle 0 key
            break;
        case GDK_KEY_plus:
        case GDK_KEY_KP_Add:
            // Handle + key
            break;
        // ... more keys
    }
    return FALSE;  // Allow other handlers to process
}
```

### 3. Add History Panel
```c
// Create text view for history
GtkWidget *history_view = gtk_text_view_new();
GtkTextBuffer *buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(history_view));

// Add to history
void add_to_history(const char *calculation) {
    GtkTextIter end;
    gtk_text_buffer_get_end_iter(buffer, &end);
    gtk_text_buffer_insert(buffer, &end, calculation, -1);
    gtk_text_buffer_insert(buffer, &end, "\n", -1);
}
```

### 4. Save/Load Functionality
```c
// Save calculations to file
void save_history(const char *filename) {
    FILE *file = fopen(filename, "w");
    if (file) {
        fprintf(file, "%s", history_text);
        fclose(file);
    }
}

// Load calculations from file
void load_history(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file) {
        fread(history_text, 1, sizeof(history_text), file);
        fclose(file);
    }
}
```

## Best Practices for GTK Development

1. **Memory Management**
   - GTK uses reference counting
   - Use g_object_unref() when done with objects
   - Widgets are automatically freed when containers are destroyed

2. **Thread Safety**
   - GTK is not thread-safe
   - Use g_idle_add() to update UI from other threads

3. **Error Handling**
   - Check return values
   - Use GError for GTK functions that support it

4. **Naming Conventions**
   - Use descriptive widget names
   - Follow GTK naming style (gtk_widget_action)

5. **Code Organization**
   - Separate UI creation from logic
   - Use header files for large projects
   - Keep callbacks focused on single tasks

## Resources

### Official Documentation
- [GTK 3 Reference Manual](https://docs.gtk.org/gtk3/)
- [GTK Tutorial](https://www.gtk.org/docs/tutorials/)

### Books
- "Foundations of GTK+ Development" by Andrew Krause
- "GTK+ Programming in C" by Syd Logan

### Online Resources
- [GTK Forums](https://discourse.gnome.org/c/platform/5)
- [Stack Overflow GTK Tag](https://stackoverflow.com/questions/tagged/gtk)

---
*Created by khlaifiabilel - 2025-11-20*
*Happy GUI Programming!*