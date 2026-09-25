# Troubleshooting

The color-resolution system performs validation, normalization, semantic resolution, and contrast evaluation during preprocessing. Most errors occur when an invalid color format, undefined semantic token, or unsupported style directive is encountered.

---

## Invalid Literal Color

### Symptom

```text
MB_UML :: Invalid literal color=[#GGGGGG]
```

### Cause

The provided color is not a valid hexadecimal color.

Supported formats:

```plantuml
#RGB
#RRGGBB
#RRGGBBAA
```

Examples of invalid values:

```plantuml
#GGGGGG
#12345
RGB(255,255,255)
Blue
```

### Resolution

Use a valid hexadecimal color:

```plantuml
#FFF
#FFFFFF
#FFFFFF00
```

---

## Undefined Semantic Color

### Symptom

```text
MB_UML :: Invalid variable name or undefined variable=[$COLOR_PRIMARY_DARKEST]
```

### Cause

A semantic color token was referenced but no corresponding variable exists.

Example:

```plantuml
BackgroundColor PRIMARY_DARKEST
```

Requires:

```plantuml
!$COLOR_PRIMARY_DARKEST = "#012345"
```

### Resolution

Either:

1. Define the semantic color variable:

```plantuml
!$COLOR_PRIMARY_DARKEST = "#012345"
```

or

2. Use an existing semantic token:

```plantuml
PRIMARY
PRIMARY_DARK
PRIMARY_LIGHT
```

---

## AUTO Requires a Context Color

### Symptom

```text
MB_UML :: AUTO (resolve_style_color) requires a context color
```

### Cause

The `AUTO` directive selects a text color based on an existing background color. No background color was available in the current resolution context.

Example:

```plantuml
FontColor AUTO
```

without a corresponding background context.

### Resolution

Provide a background color context.

Example:

```plantuml
BackgroundColor PRIMARY_DARK
FontColor AUTO
```

or:

```plantuml
FontColor $resolve_style_color(
    "AUTO",
    "PRIMARY_DARK"
)
```

---

## CURRENT Requires a Context Color

### Symptom

```text
MB_UML :: CURRENT (resolve_style_color) requires a context color
```

### Cause

`CURRENT` resolves to the current active color but no context color was supplied.

### Resolution

Ensure a parent or related style property supplies the current color.

Example:

```plantuml
BackgroundColor PRIMARY
LineColor CURRENT
```

---

## DARKEN Requires a Context Color

### Symptom

```text
MB_UML :: DARKEN (resolve_style_color) requires a context color
```

### Cause

A darkening directive was used without a source color.

Example:

```plantuml
BorderColor DARKEN
```

### Resolution

Provide a context color.

Example:

```plantuml
BackgroundColor PRIMARY
BorderColor DARKEN
```

---

## LIGHTEN Requires a Context Color

### Symptom

```text
MB_UML :: LIGHTEN (resolve_style_color) requires a context color
```

### Cause

A lightening directive was used without a source color.

### Resolution

Provide a context color.

Example:

```plantuml
BackgroundColor PRIMARY_DARK
HeaderColor LIGHTEN
```

---

## RGB Processing Error

### Symptom

```text
MB_UML :: Invalid hex byte=[ABCD]
```

or

```text
MB_UML :: Invalid hex digit=[G]
```

### Cause

An invalid hexadecimal value reached the RGB processing subsystem.

This is typically caused by:

- A malformed literal color
- An incorrectly defined semantic color variable
- A theme variable containing an invalid value

### Resolution

Verify all semantic variables resolve to valid hexadecimal colors.

Example:

```plantuml
!$COLOR_PRIMARY = "#047BC1"
```

not:

```plantuml
!$COLOR_PRIMARY = "BLUE"
```

---

## Expected Literal Color

### Symptom

```text
MB_UML :: Expected literal color=[PRIMARY_DARK]
```

### Cause

A function requiring a literal color received an unresolved semantic token.

### Resolution

Use:

```plantuml
$resolve_style_color(...)
```

or

```plantuml
$resolve_literal_color(...)
```

before invoking RGB-dependent functionality.

---

## Invalid Transformation Threshold

### Symptom

```text
MB_UML :: Invalid DARKNESS_THRESHOLD=[300]
```

or

```text
MB_UML :: Invalid LIGHTNESS_THRESHOLD=[-1]
```

### Cause

Transformation thresholds must be within the RGB luminance range.

Valid range:

```text
0 - 255
```

### Resolution

Use values within the supported range.

Example:

```plantuml
!$DARKNESS_THRESHOLD = 32
!$LIGHTNESS_THRESHOLD = 223
```

---

## Unexpected Text Color from AUTO

### Symptom

Text appears darker or lighter than expected.

### Cause

`AUTO` uses luminance-based contrast selection.

Configuration:

```plantuml
!$CONTRAST_THRESHOLD = 128
```

Rule:

```text
Luminance ≤ Threshold → Light Text
Luminance > Threshold → Dark Text
```

### Resolution

Inspect the background color:

```plantuml
!log $hex_luminance("#023451")
```

and adjust the threshold if required:

```plantuml
!$CONTRAST_THRESHOLD = 140
```

---

## Diagnostic Helpers

Helpful troubleshooting statements:

### Validate a Color

```plantuml
!log $is_literal_color("#023451")
```

### Inspect RGB Components

```plantuml
!log $hex_red("#023451")
!log $hex_green("#023451")
!log $hex_blue("#023451")
```

### Inspect Luminance

```plantuml
!log $hex_luminance("#023451")
```

### Inspect AUTO Resolution

```plantuml
!log $get_auto_text_color("#FFFFFF")
!log $get_auto_text_color("#023451")
```

### Inspect Final Resolution

```plantuml
!log $resolve_style_color(
    "AUTO",
    "PRIMARY_DARK"
)
```

These diagnostics are useful when troubleshooting theme configuration, semantic color mappings, and contrast behavior.
