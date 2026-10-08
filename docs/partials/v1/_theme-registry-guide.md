# Theme Registry Guide

## Overview

The Theme Registry provides a lightweight mechanism for registering and executing one or more themes without modifying the framework loader.

Themes are loaded in the order they are registered, allowing multiple themes to be layered together.

This enables:

- Corporate branding themes
- Product-specific themes
- Customer-specific themes
- Project-level themes
- Reusable theme packages in separate repositories

The registry is intentionally decoupled from the framework, allowing themes to be distributed independently.

---

# Architecture

The framework processes styles in the following order:

```text
BEFORE
    ↓
StdLib
    ↓
TOGAF
    ↓
Registered Themes
    ↓
AFTER
```

Where:

| Layer | Responsibility |
|----------|----------|
| BEFORE | Framework configuration and variable overrides |
| StdLib | Core framework variables and styles |
| TOGAF | Architecture semantics and TOGAF defaults |
| Registered Themes | Organizational or project themes |
| AFTER | Final overrides and local customizations |

---

# Registry Implementation

The registry maintains a collection of registered themes.

```plantuml
!$THEMES ?= []
```

Theme names are stored in registration order.

Example:

```plantuml
["Corporate"]
```

or

```plantuml
["Corporate", "Product"]
```

---

# Registering Themes

Themes are registered using:

```plantuml
Register_Theme($theme)
```

Example:

```plantuml
Register_Theme("Corporate")
```

Multiple themes:

```plantuml
Register_Theme("Corporate")
Register_Theme("Product")
```

Execution order:

```text
Corporate
    ↓
Product
```

The second theme can override settings introduced by the first theme.

---

# Theme Authoring

Each registered theme must provide two procedures.

## Variable Phase

```plantuml
Preload_Theme_<ThemeName>()
```

Used for:

- Variables
- Configuration
- Theme initialization
- Semantic mappings

Example:

```plantuml
!procedure Preload_Theme_Corporate()

    !$SPACING_UNIT = 8

!endprocedure
```

---

## Style Phase

```plantuml
Load_Lib_Styles_THEME_<ThemeName>()
```

Used for:

- Stereotypes
- Styles
- Layout defaults
- Theme-specific formatting

Example:

```plantuml
!procedure Load_Lib_Styles_THEME_Corporate()

<style>

.card {

    Padding 24

}

</style>

!endprocedure
```

---

# Theme Invocation

The framework automatically invokes registered themes.

Theme authors do not call these procedures directly.

## Variable Phase

For each registered theme:

```plantuml
Preload_Theme_<Theme>()
```

is executed.

For example:

```plantuml
Register_Theme("Corporate")
Register_Theme("Product")
```

results in:

```plantuml
Preload_Theme_Corporate()

Preload_Theme_Product()
```

---

## Style Phase

For each registered theme:

```plantuml
Load_Lib_Styles_THEME_<Theme>()
```

is executed.

For example:

```plantuml
Load_Lib_Styles_THEME_Corporate()

Load_Lib_Styles_THEME_Product()
```

---

# Creating a Theme Package

Themes are intended to be distributable and versioned independently from the framework.

A theme package typically consists of:

```text
theme-repository
│
├─ theme.puml
├─ README.md
└─ examples
```

Example:

```plantuml
Register_Theme("Corporate")


!procedure Preload_Theme_Corporate()

    !$SPACING_UNIT = 8

    !$ROUND_2 = 12

!endprocedure


!procedure Load_Lib_Styles_THEME_Corporate()

<style>

.card {

    Padding 24

    RoundCorner 12

}

</style>

!endprocedure
```

No framework files require modification.

---

# Using a Theme

Simply include the theme package.

```plantuml
!include architecture-toolkit.puml

!include corporate-theme.puml

Load_Lib_Styles_All()
```

The theme registers itself automatically.

---

# Multiple Theme Composition

Multiple themes may be loaded simultaneously.

Example:

```plantuml
Register_Theme("Corporate")
Register_Theme("Product")
Register_Theme("Customer")
```

Processing:

```text
StdLib
    ↓
TOGAF
    ↓
Corporate
    ↓
Product
    ↓
Customer
    ↓
AFTER
```

This allows:

- Base organizational standards
- Product-specific customizations
- Customer-specific branding

without duplication of theme code.

---

# Recommended Theme Design

## Base Theme

Defines broad organizational branding.

Examples:

- Colors
- Standard spacing
- Border styles
- Typography

---

## Product Theme

Extends organizational standards.

Examples:

- Application-specific cards
- Domain-specific stereotypes
- Product-specific layouts

---

## Customer Theme

Provides customer customizations.

Examples:

- Branding
- Logos
- Colour tweaks
- Presentation styles

---

# Best Practices

## Register Once

Do:

```plantuml
Register_Theme("Corporate")
```

Avoid:

```plantuml
Register_Theme("Corporate")
Register_Theme("Corporate")
```

Duplicate registrations will result in duplicate execution.

---

## Use Preload for Variables

Good:

```plantuml
!procedure Preload_Theme_Corporate()

    !$SPACING_UNIT = 8

!endprocedure
```

Avoid defining variables during the style phase.

---

## Use Load for Styles

Good:

```plantuml
!procedure Load_Lib_Styles_THEME_Corporate()

<style>

.card {
    Padding 24
}

</style>

!endprocedure
```

---

## Keep Themes Focused

Prefer:

```text
Corporate Theme
    ↓
Product Theme
```

over a single monolithic theme.

Smaller themes are easier to maintain and reuse.

---

# Example Layering Strategy

A typical enterprise implementation might look like:

```text
StdLib
    ↓
TOGAF
    ↓
Corporate Theme
    ↓
Product Theme
    ↓
Project Theme
    ↓
AFTER
```

Where:

| Layer | Example Responsibility |
|----------|----------|
| StdLib | Core utility framework |
| TOGAF | Architecture semantics |
| Corporate Theme | Organizational branding and standards |
| Product Theme | Product-specific visual patterns |
| Project Theme | Project-level extensions |
| AFTER | Diagram-local customization |

This layered approach allows themes to be independently developed, versioned, distributed, and composed while keeping the framework itself stable and unchanged.
