# Theme Usage

The theme provides:

- Color standards
- Font standards
- Border standards
- Layout standards
- Architecture stereotypes
- Reusable legend definitions

# Color Token Resolution

The style framework supports semantic color tokens, computed values, and literal colors.

## Supported Values

| Value | Description | Example |
|---------|-------------|---------|
| `AUTO` | Automatically derive an appropriate value from context. Typically used for text colors. | `COLOR_FONT_TITLE = "AUTO"` |
| `CURRENT` | Use the current component's resolved surface/background color. | `COLOR_LINE_TITLE = "CURRENT"` |
| `DARKEN` | Resolve to the next darker semantic token. Falls back to RGB darkening when no darker semantic token exists. | `COLOR_LINE_TITLE = "DARKEN"` |
| `DARKEN_n` | Resolve to the next darker semantic token. If no darker semantic token exists, darken the resolved color by *n*%. | `COLOR_LINE_TITLE = "DARKEN_20"` |
| `LIGHTEN` | Resolve to the next lighter semantic token. Falls back to RGB lightening when no lighter semantic token exists. | `COLOR_LINE_TITLE = "LIGHTEN"` |
| `LIGHTEN_n` | Resolve to the next lighter semantic token. If no lighter semantic token exists, lighten the resolved color by *n*%. | `COLOR_LINE_TITLE = "LIGHTEN_20"` |
| `*_TEXT` | Use the contrast text color for a semantic token. | `PRIMARY_DARK_TEXT` |
| Semantic Token | Resolve through the active theme. | `PRIMARY_DARK` |
| Literal Color | Use directly without transformation. | `#023451` |

## Semantic Progression

Semantic color tokens support the following progression hierarchy:

```text
LIGHTEST
    ↑
LIGHT
    ↑
BASE
    ↑
DARK
    ↑
DARKEST
```

### Example

```text
PRIMARY_LIGHTEST
    ↑
PRIMARY_LIGHT
    ↑
PRIMARY
    ↑
PRIMARY_DARK
    ↑
PRIMARY_DARKEST
```

## DARKEN Progression

```text
PRIMARY_LIGHT     → PRIMARY

PRIMARY           → PRIMARY_DARK

PRIMARY_DARK      → PRIMARY_DARKEST

PRIMARY_DARKEST   → RGB Darkening
```

## LIGHTEN Progression

```text
PRIMARY_DARKEST   → PRIMARY_DARK

PRIMARY_DARK      → PRIMARY

PRIMARY           → PRIMARY_LIGHT

PRIMARY_LIGHT     → PRIMARY_LIGHTEST

PRIMARY_LIGHTEST  → RGB Lightening
```

When a semantic token has no additional lighter or darker variant, the framework falls back to RGB color adjustment using `%lighten()` or `%darken()`.

Threshold protection prevents colors from becoming excessively close to pure black or pure white.

## Resolution Order

| Priority | Rule |
|----------|------|
| 1 | `AUTO` |
| 2 | `CURRENT` |
| 3 | `DARKEN` / `DARKEN_n` |
| 4 | `LIGHTEN` / `LIGHTEN_n` |
| 5 | `*_TEXT` |
| 6 | Semantic token |
| 7 | Literal color |

# Examples

## Automatic Text and Border Resolution

### Configuration

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY_DARK"
!$COLOR_FONT_TITLE       = "AUTO"
!$COLOR_LINE_TITLE       = "CURRENT"
```

### Result

```text
BackgroundColor = PRIMARY_DARK
FontColor       = ContrastText(PRIMARY_DARK)
LineColor       = PRIMARY_DARK
```

---

## Semantic Darkening

### Configuration

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY"
!$COLOR_LINE_TITLE       = "DARKEN"
```

### Result

```text
BackgroundColor = PRIMARY
LineColor       = PRIMARY_DARK
```

---

## Semantic Lightening

### Configuration

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY_DARK"
!$COLOR_LINE_TITLE       = "LIGHTEN"
```

### Result

```text
BackgroundColor = PRIMARY_DARK
LineColor       = PRIMARY
```

---

## RGB Fallback Darkening

### Configuration

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY_DARKEST"
!$COLOR_LINE_TITLE       = "DARKEN_20"
```

### Result

```text
LineColor = %darken(PRIMARY_DARKEST, 20)
```

Threshold protection will be applied if the resulting color becomes too close to black.

---

## RGB Fallback Lightening

### Configuration

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY_LIGHTEST"
!$COLOR_LINE_TITLE       = "LIGHTEN_20"
```

### Result

```text
LineColor = %lighten(PRIMARY_LIGHTEST, 20)
```

Threshold protection will be applied if the resulting color becomes too close to white.