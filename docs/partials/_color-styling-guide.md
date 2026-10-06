# PlantUML Color Styling Guide

## Overview

The PlantUML styling framework uses a layered color resolution pipeline inspired by modern CSS and SASS design systems.

Rather than applying hardcoded RGB values directly in styles, colors flow through a controlled resolution process that supports:

- Theme overrides
- Semantic color tokens
- Context-aware color computation
- Automatic contrast management
- Darkening and lightening operations
- Luminance normalization

This approach allows styles to remain semantic and theme-independent while ensuring visually consistent output.

---

# Color Resolution Pipeline

```text
Theme Variables
        ↓
Semantic Tokens
        ↓
resolve_style_color()
        ↓
AUTO
CURRENT
DARKEN
LIGHTEN
        ↓
Literal RGB
        ↓
normalize_darkness_floor()
normalize_lightness_ceiling()
        ↓
Style Output
```

---

# Layer 1: Theme Variables

Theme variables define the visual identity of a theme.

Examples:

```plantuml
!$COLOR_OH_PRIMARY        = "#047BC1"
!$COLOR_OH_PRIMARY_DARK   = "#023451"

!$COLOR_OH_WARNING        = "#FCAF17"
!$COLOR_OH_SUCCESS        = "#118847"
```

When a theme is enabled:

```plantuml
!$COLOR_PRIMARY      = $COLOR_OH_PRIMARY
!$COLOR_PRIMARY_DARK = $COLOR_OH_PRIMARY_DARK
```

All downstream styles continue to use semantic tokens.

They never reference theme-specific colors directly.

---

# Layer 2: Semantic Tokens

Semantic tokens represent intent rather than color values.

## Good

```plantuml
PRIMARY
PRIMARY_DARK

WARNING
SUCCESS

ERROR
```

## Avoid

```plantuml
"#047BC1"
"#023451"
```

inside reusable components.

---

## Why Semantic Tokens Matter

A component written as:

```plantuml
BackgroundColor PRIMARY
```

can inherit colors from:

- Default theme
- Ontario Health theme
- TOGAF theme
- Future themes

without modification.

---

# Layer 3: resolve_style_color()

Every style should pass through:

```plantuml
$resolve_style_color()
```

This function is the single source of truth for color resolution.

Examples:

```plantuml
$resolve_style_color("PRIMARY")
```

```plantuml
$resolve_style_color("AUTO", "PRIMARY_DARK")
```

```plantuml
$resolve_style_color("LIGHTEN", "PRIMARY")
```

---

## Responsibilities

The resolver handles:

- Semantic colors
- Literal colors
- AUTO
- CURRENT
- DARKEN
- LIGHTEN

before returning a final color.

---

# Layer 4: Special Style Tokens

Special style tokens perform context-aware transformations.

---

## AUTO

### Purpose

Automatically choose an appropriate foreground color.

Example:

```plantuml
$resolve_style_color(
    "AUTO",
    "PRIMARY_DARK"
)
```

Result:

```text
White text on dark backgrounds
Dark text on light backgrounds
```

### Use For

```plantuml
FontColor
```

properties.

---

## CURRENT

### Purpose

Reuse the nearest available context color.

Example:

```plantuml
!$COLOR_LINE_TITLE = "CURRENT"
```

Result:

```text
Uses current background color.
```

Useful when:

```text
LineColor should match BackgroundColor
```

without duplicating values.

---

## DARKEN

### Purpose

Generate a darker variation of a color.

Example:

```plantuml
$resolve_style_color(
    "DARKEN",
    "PRIMARY"
)
```

---

### Resolution Order

```text
PRIMARY_LIGHT
    → PRIMARY

PRIMARY
    → PRIMARY_DARK

PRIMARY_DARK
    → PRIMARY_DARKEST
```

If no darker semantic variant exists:

```text
RGB darkening is performed
```

---

### Percentage Variants

```plantuml
DARKEN
DARKEN_10
DARKEN_20
DARKEN_30
```

Examples:

```plantuml
$resolve_style_color(
    "DARKEN_20",
    "#80C0FF"
)
```

---

## LIGHTEN

### Purpose

Generate a lighter variation of a color.

Example:

```plantuml
$resolve_style_color(
    "LIGHTEN",
    "PRIMARY"
)
```

---

### Resolution Order

```text
PRIMARY_DARKEST
    → PRIMARY_DARK

PRIMARY_DARK
    → PRIMARY

PRIMARY
    → PRIMARY_LIGHT

PRIMARY_LIGHT
    → PRIMARY_LIGHTEST
```

If no semantic promotion exists:

```text
RGB lightening is performed
```

---

### Percentage Variants

```plantuml
LIGHTEN
LIGHTEN_10
LIGHTEN_20
LIGHTEN_30
```

---

# Layer 5: Literal RGB Resolution

After semantic resolution, all colors become literal RGB values.

Example:

```plantuml
PRIMARY_DARK
```

becomes

```plantuml
#023451
```

At this stage all theme abstraction has been removed.

Further processing operates exclusively on RGB values.

---

# Layer 6: Luminance Normalization

The framework prevents colors from becoming unreadably dark or bright.

---

## normalize_darkness_floor()

### Purpose

Enforce minimum luminance.

Example:

```plantuml
#050505
```

may become:

```plantuml
#202020
```

if luminance falls below:

```plantuml
$DARKNESS_THRESHOLD
```

---

### Why

Prevents:

```text
Near-black colors
Unreadable borders
Invisible text
```

---

## normalize_lightness_ceiling()

### Purpose

Enforce maximum luminance.

Example:

```plantuml
#FFFFFF
```

may be reduced to:

```plantuml
#EFEFEF
```

if luminance exceeds:

```plantuml
$LIGHTNESS_THRESHOLD
```

---

### Why

Prevents:

```text
Near-white colors
Low contrast surfaces
Washed out containers
```

---

# Layer 7: Style Output

The final literal color is written into the generated style.

Example:

```plantuml
!$background =
    $resolve_style_color(
        "LIGHTEN",
        "PRIMARY"
    )
```

produces:

```plantuml
BackgroundColor #D6EAF8
```

or another resolved value depending on:

- theme
- semantic progression
- RGB transforms
- luminance normalization

---

# Recommended Usage

## Prefer Semantic Tokens

✅ Good

```plantuml
PRIMARY
PRIMARY_DARK
WARNING
ERROR
```

❌ Avoid

```plantuml
#047BC1
#023451
```

---

## Use AUTO For Text Colors

✅ Good

```plantuml
FontColor AUTO
```

❌ Avoid

```plantuml
FontColor #FFFFFF
FontColor #000000
```

unless absolutely necessary.

---

## Use CURRENT For Related Colors

✅ Good

```plantuml
BackgroundColor PRIMARY_DARK
LineColor CURRENT
```

Avoid duplicating color definitions.

---

## Use LIGHTEN/DARKEN For Variations

✅ Good

```plantuml
LIGHTEN
LIGHTEN_10

DARKEN
DARKEN_10
```

❌ Avoid creating manual variants:

```plantuml
#0A6AA3
#0B5D95
#0C5187
```

---

## Let The Resolver Work

A style should prefer:

```plantuml
$resolve_style_color(...)
```

over manual RGB handling.

The resolver ensures:

- theme awareness
- semantic progression
- contrast management
- luminance safety

remain consistent across the entire library.

---

# Design Principle

> Components should describe intent, not colors.

Write:

```plantuml
PRIMARY
AUTO
CURRENT
LIGHTEN
DARKEN
```

and allow the resolver pipeline to translate intent into a safe, theme-specific, presentation-ready RGB value.
