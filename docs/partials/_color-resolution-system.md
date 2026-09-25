# Color Resolution

The library provides a layered color-resolution system that supports semantic color tokens, literal colors, automatic contrast selection, and color transformations.

Colors are resolved through the following pipeline:

```text
Style Directive
      ↓
Semantic Resolution
      ↓
Literal Color
      ↓
RGB Processing
      ↓
Contrast Evaluation
      ↓
Final Resolved Color
```

This architecture allows diagrams to remain theme-independent while ensuring consistent, readable, and accessible color usage.

---

# Supported Color Formats

| Format | Example | Description |
|----------|----------|----------|
| Semantic Token | `PRIMARY` | Theme-defined color |
| Semantic Variant | `PRIMARY_DARK` | Theme-defined color variant |
| Short Hex | `#FFF` | Expanded to `#FFFFFF` |
| RGB Hex | `#023451` | Standard 24-bit RGB color |
| RGBA Hex | `#FFFFFF00` | Alpha component is ignored during RGB and contrast calculations |
| AUTO Directive | `AUTO` | Automatically selects a readable text color |
| CURRENT Directive | `CURRENT` | Uses the current color context |
| Darken Directive | `DARKEN`, `DARKEN_20` | Darkens the current color context |
| Lighten Directive | `LIGHTEN`, `LIGHTEN_20` | Lightens the current color context |

---

# Color Directives and Transformations

The resolver supports a set of directives that provide inheritance, automatic contrast handling, and dynamic color transformations.

| Directive | Example | Description | Result |
|------------|------------|------------|------------|
| `AUTO` | `FontColor AUTO` | Selects a readable text color based on background luminance. | Dark or light text color |
| `CURRENT` | `LineColor CURRENT` | Uses the current context color without modification. | Current resolved color |
| `DARKEN` | `BorderColor DARKEN` | Darkens the current context color using the default percentage. | Darker variation |
| `DARKEN_n` | `BorderColor DARKEN_20` | Darkens the current context color by the specified percentage. | Darker variation |
| `LIGHTEN` | `BackgroundColor LIGHTEN` | Lightens the current context color using the default percentage. | Lighter variation |
| `LIGHTEN_n` | `BackgroundColor LIGHTEN_30` | Lightens the current context color by the specified percentage. | Lighter variation |

### Directive Resolution Order

Directives operate against the nearest available color context.

```plantuml
AUTO
CURRENT
DARKEN
LIGHTEN
```

Example:

```plantuml
BackgroundColor PRIMARY
BorderColor DARKEN
```

Resolution:

```text
PRIMARY
      ↓
#047BC1
      ↓
DARKEN
      ↓
20% Darker
      ↓
Final Border Color
```

---

# Semantic Colors

Semantic colors provide theme independence.

Instead of specifying literal colors directly:

```plantuml
BackgroundColor #023451
```

use semantic tokens:

```plantuml
BackgroundColor PRIMARY_DARK
```

The resolver maps semantic tokens to the currently configured theme values.

Example:

```text
PRIMARY_DARK
        ↓
COLOR_PRIMARY_DARK
        ↓
#023451
```

This allows themes to change color palettes without modifying diagrams.

---

# Automatic Text Color Selection (AUTO)

The `AUTO` directive automatically selects a readable foreground color based on the luminance of the background color.

`AUTO` supports both semantic tokens and literal colors.

### Semantic Background

```plantuml
FontColor AUTO
BackgroundColor PRIMARY_DARK
```

Resolution:

```text
PRIMARY_DARK
      ↓
#023451
      ↓
Luminance = 40
      ↓
#FFFFFF
```

### Literal Background

```plantuml
FontColor AUTO
BackgroundColor #FFFFFF
```

Resolution:

```text
#FFFFFF
      ↓
Luminance = 255
      ↓
#1A1A1A
```

---

# CURRENT

The `CURRENT` directive resolves to the active context color.

Example:

```plantuml
BackgroundColor PRIMARY
LineColor CURRENT
```

Resolution:

```text
PRIMARY
      ↓
#047BC1
      ↓
CURRENT
      ↓
#047BC1
```

This is useful when multiple style properties should share the same resolved color.

---

# Contrast Evaluation

Text contrast is determined using RGB luminance.

Configuration:

```plantuml
!$CONTRAST_THRESHOLD ?= 128
```

Rule:

```text
Luminance ≤ 128  → Light Text
Luminance > 128  → Dark Text
```

This evaluation is performed automatically whenever `AUTO` is used.

---

# Color Transformations

The resolver supports dynamic color transformations.

## DARKEN

Uses the default darkening percentage.

```plantuml
BorderColor DARKEN
```

Configured by:

```plantuml
!$DARKEN_DEFAULT_PERCENT = 20
```

Equivalent to:

```plantuml
BorderColor DARKEN_20
```

---

## DARKEN_n

Applies a specific darkening percentage.

```plantuml
BorderColor DARKEN_30
```

---

## LIGHTEN

Uses the default lightening percentage.

```plantuml
BackgroundColor LIGHTEN
```

Configured by:

```plantuml
!$LIGHTEN_DEFAULT_PERCENT = 20
```

Equivalent to:

```plantuml
BackgroundColor LIGHTEN_20
```

---

## LIGHTEN_n

Applies a specific lightening percentage.

```plantuml
BackgroundColor LIGHTEN_30
```

---

# Semantic Promotion

Where semantic variants exist, transformations preferentially use semantic variants before performing RGB manipulation.

This preserves theme semantics and improves visual consistency.

| Input | Transformation | Result |
|---------|---------|---------|
| `PRIMARY_LIGHT` | `DARKEN` | `PRIMARY` |
| `PRIMARY` | `DARKEN` | `PRIMARY_DARK` |
| `PRIMARY_DARK` | `LIGHTEN` | `PRIMARY` |
| `PRIMARY` | `LIGHTEN` | `PRIMARY_LIGHT` |

Only when no appropriate semantic variant exists will RGB lightening or darkening be applied.

---

# Transformation Safety Limits

Color transformations are protected against collapsing into pure black or pure white.

| Variable | Default | Purpose |
|----------|----------|----------|
| `DARKNESS_THRESHOLD` | `32` | Prevents excessive darkening |
| `LIGHTNESS_THRESHOLD` | `223` | Prevents excessive lightening |
| `CONTRAST_THRESHOLD` | `128` | Controls AUTO text-color selection |

Example:

```text
#010101
    ↓ DARKEN
#202020
```

instead of:

```text
#000000
```

and:

```text
#FEFEFE
    ↓ LIGHTEN
#DFDFDF
```

instead of:

```text
#FFFFFF
```

These limits apply only to transformation operations and are independent of the contrast evaluation used by `AUTO`.

---

# Color Validation

All literal colors are validated before RGB processing.

Supported formats:

```plantuml
#RGB
#RRGGBB
#RRGGBBAA
```

Invalid colors produce descriptive preprocessing errors.

Example:

```plantuml
#GGGGGG
```

Produces:

```text
MB_UML :: Invalid literal color=[#GGGGGG]
```

---

# Resolution Examples

## Semantic Color

```plantuml
BackgroundColor PRIMARY_DARK
```

Resolution:

```text
PRIMARY_DARK
        ↓
COLOR_PRIMARY_DARK
        ↓
#023451
```

---

## Semantic AUTO Text

```plantuml
FontColor AUTO
BackgroundColor PRIMARY_DARK
```

Resolution:

```text
PRIMARY_DARK
        ↓
#023451
        ↓
#FFFFFF
```

---

## Literal AUTO Text

```plantuml
FontColor AUTO
BackgroundColor #FFFFFF
```

Resolution:

```text
#FFFFFF
        ↓
#1A1A1A
```

---

## Darkening

```plantuml
BorderColor DARKEN_20
Context = PRIMARY
```

Resolution:

```text
PRIMARY
        ↓
#047BC1
        ↓
20% Darker
        ↓
Final Border Color
```

---

## Lightening

```plantuml
BackgroundColor LIGHTEN_30
Context = PRIMARY_DARK
```

Resolution:

```text
PRIMARY_DARK
        ↓
#023451
        ↓
30% Lighter
        ↓
Final Background Color
```

---

# Summary

The color-resolution system provides:

- Theme-independent semantic colors
- Automatic contrast-aware text colors
- Support for literal RGB and RGBA colors
- Dynamic lightening and darkening
- Semantic color progression
- Color validation and normalization
- Safe transformation limits
- Consistent, deterministic color resolution

Diagram authors can focus on semantic intent while the library handles color resolution, contrast selection, and transformation behavior automatically.
