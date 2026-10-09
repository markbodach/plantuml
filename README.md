


# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

## Core Bundle

* Compiled Bundle: **`all.puml`**

## Theme Bundles

Any discovered theme repositories are compiled as:

```text
theme-<theme-name>.puml
```

Example:

```text
theme-corporate.puml
theme-panelapp.puml
```

## Build Metadata

* Generated on: **2026-10-09 16:28:05 EDT**
* Build Commit Hash: **c41ed04fd2f1de8876fe60257acb0f1b1f7168af**
* Build Commit Comment: **text module refactoring**

## Usage

```plantuml
@startuml

!define MBpuml https://markbodach.github.io/plantuml

!includeurl MBpuml/all.puml

!includeurl MBpuml/theme-corporate.puml

Register_Theme("Corporate")

Load_Lib_Styles_All()

@enduml
```


# PlantUML Architecture Framework

## Complete Framework, Theme, Styling, and Troubleshooting Guide

This guide is the consolidated reference for using, extending, theming, building, and troubleshooting the PlantUML Architecture Framework. It replaces the earlier collection of overlapping documents with a single ordered narrative.

The stable core contains **StdLib** and **TOGAF** support. Optional themes are compiled and distributed independently, included statically, registered explicitly, and executed in deterministic registration order.

## Table of Contents

1. [Introduction and Design Principles](#chapter-1-introduction-and-design-principles)
2. [Installation and Quick Start](#chapter-2-installation-and-quick-start)
3. [Runtime Architecture and Processing Order](#chapter-3-runtime-architecture-and-processing-order)
4. [Distribution and Repository Structure](#chapter-4-distribution-and-repository-structure)
5. [Theme Registry](#chapter-5-theme-registry)
6. [Authoring and Packaging Themes](#chapter-6-authoring-and-packaging-themes)
7. [Framework Extensibility](#chapter-7-framework-extensibility)
8. [Utility Stereotypes](#chapter-8-utility-stereotypes)
9. [Color Resolution](#chapter-9-color-resolution)
10. [Text Utilities](#chapter-10-text-utilities)
11. [Troubleshooting](#chapter-11-troubleshooting)
12. [Debugging and Diagnostics](#chapter-12-debugging-and-diagnostics)
13. [Build and Generated Documentation](#chapter-13-build-and-generated-documentation)

---
## Chapter 1: Introduction and Design Principles

### Purpose

The framework provides:

- Architecture-focused PlantUML styling
- TOGAF-aligned semantic modelling support
- Registry-based, ordered theme composition
- Semantic color resolution and contrast-aware text colors
- Bootstrap-inspired utility stereotypes
- Reusable architecture components and extension hooks
- Independently distributable theme bundles

### Architectural Model

```text
Core Framework
    ↓
Registered Theme(s)
    ↓
Project Customization
```

The registry controls **execution**, not file discovery. PlantUML files are loaded statically with `!include` or `!includeurl`; registration controls which already-loaded theme procedures participate in `Load_Lib_Styles_All()`.

### Design Principles

1. Keep the core framework stable.
2. Keep optional themes outside the core bundle.
3. Compile each theme as an independently distributable asset.
4. Make theme composition deterministic through registration order.
5. Use preload procedures for variables and load procedures for styles.
6. Prefer semantic tokens and reusable stereotypes over diagram-local literals.
7. Use BEFORE and AFTER hooks for consumer customization instead of editing framework internals.
8. Treat registered theme names and generated procedure names as a public contract.

---
## Chapter 2: Installation and Quick Start

### Core Framework Only

```plantuml
@startuml

!define MBpuml https://markbodach.github.io/plantuml
!includeurl MBpuml/all.puml

Load_Lib_Styles_All()

rectangle "Core Component" <<card>>

@enduml
```

### Core Framework with One Theme

```plantuml
@startuml

!define MBpuml https://markbodach.github.io/plantuml
!includeurl MBpuml/all.puml
!includeurl MBpuml/theme-corporate.puml

Register_Theme("Corporate")
Load_Lib_Styles_All()

rectangle "Themed Component" <<card>>

@enduml
```

A theme bundle may instead self-register. Pick one convention—consumer registration or self-registration—and apply it consistently. Do not document both as the normal path.

### Multiple Themes

```plantuml
@startuml

!define MBpuml https://markbodach.github.io/plantuml
!includeurl MBpuml/all.puml
!includeurl MBpuml/theme-corporate.puml
!includeurl MBpuml/theme-product.puml

Register_Theme("Corporate")
Register_Theme("Product")

Load_Lib_Styles_All()

@enduml
```

Execution order:

```text
StdLib
    ↓
TOGAF
    ↓
Corporate
    ↓
Product
```

Later themes may override variables or styles introduced by earlier themes.

---
## Chapter 3: Runtime Architecture and Processing Order

`Load_Lib_Styles_All()` executes two phases. The preload phase establishes the values used to generate styles. The load phase emits styles.

```text
Preload_Lib_Styles_BEFORE()
    ↓
Preload_Lib_Styles_Stdlib()
    ↓
Preload_Lib_Styles_Togaf()
    ↓
Invoke_Preload_Themes()
    ↓
Preload_Lib_Styles_AFTER()

Load_Lib_Styles_BEFORE()
    ↓
Load_Lib_Styles_Stdlib()
    ↓
Load_Lib_Styles_Togaf()
    ↓
Invoke_Load_Themes()
    ↓
Load_Lib_Styles_AFTER()
```

| Layer | Responsibility |
|---|---|
| BEFORE | Consumer configuration before framework processing |
| StdLib | Core variables, helpers, utilities, and styles |
| TOGAF | Architecture semantics and TOGAF defaults |
| Registered Themes | Organizational, product, customer, or project themes |
| AFTER | Final variable adjustments and style overrides |

### Why There Are Two Phases

Variables must be resolved before styles reference them. Defining variables inside the load phase is usually too late because style-producing procedures may already have calculated dependent values. Therefore:

- Put configuration, semantic mappings, and derived variables in **Preload** procedures.
- Put `<style>` blocks and style emission in **Load** procedures.

---

## Chapter 4: Distribution and Repository Structure

### Core Distribution

The core bundle contains StdLib and TOGAF support:

```text
all.puml
```

### Theme Distribution

Every immediate child folder under `src/themes` is compiled independently:

```text
src/themes/<folder-name>/index.puml
    ↓
theme-<folder-name>.puml
```

Examples:

```text
theme-corporate.puml
theme-product.puml
theme-customer.puml
```

Themes are not embedded in `all.puml`. A diagram includes only the theme bundles it needs.

### Source Layout

# All Override PlantUML Variables

This list is generated from the repository's puml source code.

Use these variables before loading the repository.

```plantuml
@startuml

!$ALIGNMENT_HORIZONTAL_COMPONENT = "left"
!$ALIGNMENT_HORIZONTAL_ELEMENT = "left"
!$ALIGNMENT_HORIZONTAL_TITLE = "center"
!$BORDER_0 = 0
!$BORDER_1 = 1
!$BORDER_2 = 2
!$BORDER_3 = 3
!$BORDER_4 = 4
!$BORDER_THICKNESS_BOLD = 2
!$BORDER_THICKNESS_POD = 2
!$BORDER_THICKNESS = 1
!$COLOR_APPLICATION_DARK = $COLOR_TOGAF_APPLICATION
!$COLOR_APPLICATION_LIGHT = $COLOR_TOGAF_APPLICATION
!$COLOR_BACKGROUND_ACTOR = "#90CAF9"
!$COLOR_BACKGROUND_COMPONENT = $COLOR_PRIMARY
!$COLOR_BACKGROUND_ELEMENT_COMPOSITE = $COLOR_PRIMARY_LIGHT
!$COLOR_BACKGROUND_ELEMENT = $COLOR_PRIMARY
!$COLOR_BACKGROUND_TITLE = $COLOR_PRIMARY_LIGHT
!$COLOR_BACKGROUND = $COLOR_PRIMARY_LIGHT
!$COLOR_BODY = "#ffffff"
!$COLOR_BORDER_ACTOR = "#0D47A1"
!$COLOR_BORDER_RECTANGLE = $COLOR_NONE
!$COLOR_BORDER = "#5D6D7E"
!$COLOR_BUSINESS_DARK = $COLOR_TOGAF_BUSINESS
!$COLOR_BUSINESS_LIGHT = $COLOR_TOGAF_BUSINESS
!$COLOR_DISABLED_DARK = "#4D4D4D"
!$COLOR_DISABLED_LIGHT = "#737373"
!$COLOR_DISABLED = "#737373"
!$COLOR_ERROR_DARK = "#CD0000"
!$COLOR_ERROR_LIGHT = "#CD0000"
!$COLOR_ERROR = "#CD0000"
!$COLOR_FONT_COMPONENT = $COLOR_FONT
!$COLOR_FONT_ELEMENT = $COLOR_FONT
!$COLOR_FONT_TITLE = $COLOR_FONT
!$COLOR_FONT = $COLOR_TEXT
!$COLOR_HIGHLIGHTED_DARK = $COLOR_TOGAF_HIGHLIGHTED
!$COLOR_HIGHLIGHTED_LIGHT = $COLOR_TOGAF_HIGHLIGHTED
!$COLOR_IMPLEMENTATION_DARK = $COLOR_TOGAF_IMPLEMENTATION
!$COLOR_IMPLEMENTATION_LIGHT = $COLOR_TOGAF_IMPLEMENTATION
!$COLOR_LINE_COMPONENT = $COLOR_LINE
!$COLOR_LINE_ELEMENT = $COLOR_LINE
!$COLOR_LINE_TITLE = $COLOR_LINE
!$COLOR_LINE = $COLOR_TEXT
!$COLOR_MOTIVATION_DARK = $COLOR_TOGAF_MOTIVATION
!$COLOR_MOTIVATION_LIGHT = $COLOR_TOGAF_MOTIVATION
!$COLOR_NEW_DARK = $COLOR_TOGAF_NEW
!$COLOR_NEW_LIGHT = $COLOR_TOGAF_NEW
!$COLOR_NONE = $COLOR_TRANSPARENT
!$COLOR_PRIMARY_DARK = "#D6EAF8"
!$COLOR_PRIMARY_LIGHT = "#D6EAF8"
!$COLOR_PRIMARY = "#D6EAF8"
!$COLOR_STRATEGY_DARK = $COLOR_TOGAF_STRATEGY
!$COLOR_STRATEGY_LIGHT = $COLOR_TOGAF_STRATEGY
!$COLOR_SUCCESS_DARK = "#D5F5E3"
!$COLOR_SUCCESS_LIGHT = "#D5F5E3"
!$COLOR_SUCCESS = "#D5F5E3"
!$COLOR_TECHNOLOGY_DARK = $COLOR_TOGAF_TECHNOLOGY
!$COLOR_TECHNOLOGY_LIGHT = $COLOR_TOGAF_TECHNOLOGY
!$COLOR_TEXT_LIGHT = $COLOR_BODY
!$COLOR_TEXT = "#000000"
!$COLOR_TOGAF_APPLICATION = "#99FFFF"
!$COLOR_TOGAF_BUSINESS = "#FFFF99"
!$COLOR_TOGAF_HIGHLIGHTED = "#005DEF"
!$COLOR_TOGAF_IMPLEMENTATION = "#FFE0E0"
!$COLOR_TOGAF_MOTIVATION = "#CCCCFF"
!$COLOR_TOGAF_NEW = "#005700"
!$COLOR_TOGAF_STRATEGY = "#F5DEAA"
!$COLOR_TOGAF_TECHNOLOGY = "#AFFFAF"
!$COLOR_WARNING_DARK = "#FCF3CF"
!$COLOR_WARNING_LIGHT = "#FCF3CF"
!$COLOR_WARNING = "#FCF3CF"
!$CONTRAST_THRESHOLD = 128
!$DEFAULT_TEXT_ALIGNMENT = "center"
!$HEIGHT_LG = 150
!$HEIGHT_MD = 100
!$HEIGHT_SM = 75
!$HEIGHT_XL = 200
!$HEIGHT_XS = 50
!$LINE_TYPE = "ortho"
!$MARGIN_COMPONENT = 20
!$MARGIN_ELEMENT = 20
!$MARGIN_TITLE = 20
!$MARGIN = 15
!$NAME_FONT = "Segoe UI"
!$NODE_SEP = 75
!$PADDING_COMPONENT = 15
!$PADDING_ELEMENT = 15
!$PADDING_TITLE = 15
!$PADDING = 10
!$RANK_SEP = 75
!$ROUND_0 = 0
!$ROUND_1 = 5
!$ROUND_2 = 10
!$ROUND_3 = 15
!$ROUND_4 = 20
!$ROUND_5 = 30
!$ROUND_CIRCLE = 100
!$ROUND_CORNER_COMPONENT = $ROUND_CORNER
!$ROUND_CORNER_ELEMENT = $ROUND_CORNER
!$ROUND_CORNER_TITLE = $ROUND_CORNER
!$ROUND_CORNER = 10
!$ROUND_PILL = 50
!$SHADOWING = %false()
!$SIZE_BORDER_ACTOR = 3
!$SIZE_FONT_ARROW = 11
!$SIZE_FONT_LEGEND = 11
!$SIZE_FONT_TITLE = 18
!$SIZE_FONT = 12
!$SIZE_LINE_COMPONENT = $SIZE_LINE
!$SIZE_LINE_ELEMENT = $SIZE_LINE
!$SIZE_LINE_TITLE = $SIZE_LINE
!$SIZE_LINE = 2
!$SKINPARAM_ENABLED = %false()
!$SPACING_0 = 0
!$SPACING_1 = ($SPACING_UNIT * 1)
!$SPACING_2 = ($SPACING_UNIT * 2)
!$SPACING_3 = ($SPACING_UNIT * 3)
!$SPACING_4 = ($SPACING_UNIT * 4)
!$SPACING_5 = ($SPACING_UNIT * 6)
!$SPACING_UNIT_ENABLED = %true()
!$SPACING_UNIT = 5
!$STYLE_ACTOR = awesome
!$STYLE_FONT_COMPONENT = ""
!$STYLE_FONT_ELEMENT = ""
!$STYLE_FONT_TITLE = "bold"
!$THEMES = "|"
!$TOGAF_LIB_ENABLED = %false()
!$WIDTH_LG = 350
!$WIDTH_MD = 250
!$WIDTH_SM = 150
!$WIDTH_XL = 500
!$WIDTH_XS = 75
!$WIDTH_XXL = 700

@enduml
```



### Theme Package Layout

`index.puml` is the static package entry point. It includes the package files required to define the theme procedures. The registry does not dynamically include them.

## 📦 Bundled Repository Tree

This tree maps out exactly how the source code files were evaluated and sequenced into the final `all.puml` production asset.

```text
src/all.puml (Root Master)
  └── index.puml
    └── libs/index.puml
      └── stdlib/framework/index.puml
        └── _registry.puml
        └── _extensions.puml
      └── stdlib/vars/index.puml
        └── _index.puml
        └── _colors.puml
        └── _fonts.puml
        └── _spacing.puml
        └── _borders.puml
        └── _corner.puml
        └── _width.puml
        └── _height.puml
        └── _layout.puml
        └── _icons.puml
        └── _element.puml
        └── _title.puml
        └── _component.puml
      └── togaf/vars/index.puml
        └── _index.puml
        └── _colors.puml
        └── _fonts.puml
      └── stdlib/components/index.puml
        └── _strings.puml
        └── _variables.puml
        └── _text.puml
        └── _hex.puml
        └── _colors.puml
        └── _darken.puml
        └── _lighten.puml
        └── _resolver.puml
      └── togaf/components/index.puml
        └── _functions.puml
        └── _colors.puml
      └── stdlib/theme/index.puml
      └── togaf/theme/index.puml
      └── stdlib/skinparam/index.puml
      └── togaf/skinparam/index.puml
      └── stdlib/styles/index.puml
        └── _utilities.puml
        └── _card.puml
        └── _panel.puml
        └── _containers.puml
        └── _title.puml
        └── _element.puml
        └── _component.puml
      └── togaf/styles/index.puml
```

---
## Chapter 5: Theme Registry

### Registering a Theme

```plantuml
Register_Theme("Corporate")
```

Multiple themes:

```plantuml
Register_Theme("Corporate")
Register_Theme("Product")
Register_Theme("Project")
```

Duplicate registration is ignored by the guarded `Register_Theme()` implementation.

### Required Procedure Names

Every registered theme must define both procedures below.

#### Preload Phase

```plantuml
Preload_Lib_Styles_THEME_<ThemeName>()
```

Use it for variables, semantic mappings, and theme configuration:

```plantuml
!procedure Preload_Lib_Styles_THEME_Corporate()
    !$SPACING_UNIT = 8
    !$ROUND_2 = 12
    !$COLOR_PRIMARY = "#123456"
!endprocedure
```

#### Load Phase

```plantuml
Load_Lib_Styles_THEME_<ThemeName>()
```

Use it for styles and stereotypes:

```plantuml
!procedure Load_Lib_Styles_THEME_Corporate()
<style>
.card {
    Padding 24
    RoundCorner 12
}
</style>
!endprocedure
```

The spelling and casing of `<ThemeName>` must exactly match the value passed to `Register_Theme()`.

### Invocation

Given:

```plantuml
Register_Theme("Corporate")
Register_Theme("Product")
```

`Invoke_Preload_Themes()` dynamically invokes:

```plantuml
Preload_Lib_Styles_THEME_Corporate()
Preload_Lib_Styles_THEME_Product()
```

`Invoke_Load_Themes()` dynamically invokes:

```plantuml
Load_Lib_Styles_THEME_Corporate()
Load_Lib_Styles_THEME_Product()
```

PlantUML does not provide a portable procedure-existence test. Registering a theme whose procedures are absent or misspelled will fail when `%invoke_procedure()` executes. Registration is therefore a contract.

### File Loading versus Theme Execution

The registry cannot dynamically include files. This pattern is invalid as a dynamic loading mechanism:

```plantuml
!procedure Some_Procedure()
    !include theme-file.puml
!endprocedure
```

Use static includes first, then register:

```plantuml
!includeurl MBpuml/all.puml
!includeurl MBpuml/theme-corporate.puml

Register_Theme("Corporate")
Load_Lib_Styles_All()
```

Conceptually:

```text
!include / !includeurl
    ↓
Theme procedures are defined
    ↓
Register_Theme()
    ↓
Registry determines execution order
    ↓
Load_Lib_Styles_All()
```

### Registration Convention

Choose one project-wide convention:

#### Consumer Registration

The bundle defines procedures; the diagram registers the theme:

```plantuml
!includeurl MBpuml/theme-corporate.puml
Register_Theme("Corporate")
```

#### Self-Registration

The bundle calls `Register_Theme("Corporate")`; the diagram only includes it.

Do not mix conventions or the documentation becomes ambiguous. Guarding duplicate registration prevents repeated execution, but it does not fix unclear ownership.

### Best Practices

- Register themes once and in intentional order.
- Keep theme names stable because they are part of generated procedure names.
- Avoid spaces, punctuation, and hyphens in registered names; prefer `Corporate`, `ProductDark`, or `CustomerA`.
- Use preload procedures for variable assignment.
- Use load procedures for `<style>` output.
- Keep themes focused and composable.
- Treat the registry as an execution registry, not a dependency loader.

---

## Chapter 6: Authoring and Packaging Themes

### Theme Contract

A registered theme named `Corporate` must define both procedures exactly:

```plantuml
!procedure Preload_Lib_Styles_THEME_Corporate()
    ' Variables and semantic mappings
!endprocedure

!procedure Load_Lib_Styles_THEME_Corporate()
    ' Styles and stereotypes
!endprocedure
```

Even when a theme has nothing to do in one phase, define an empty procedure. PlantUML has no portable procedure-existence check, and `%invoke_procedure()` will fail if the generated name is absent.

### Preload Example

```plantuml
!procedure Preload_Lib_Styles_THEME_Corporate()
    !$COLOR_PRIMARY = "#123456"
    !$COLOR_PRIMARY_LIGHT = "#D9E3EC"
    !$COLOR_PRIMARY_DARK = "#0A2438"
    !$SPACING_UNIT = 8
    !$ROUND_2 = 12
!endprocedure
```

### Load Example

```plantuml
!procedure Load_Lib_Styles_THEME_Corporate()
<style>
.corporateCard {
    Padding $SPACING_3
    RoundCorner $ROUND_2
    Shadowing true
}
</style>
!endprocedure
```

### Entry Point Example

```plantuml
' src/themes/corporate/index.puml

!include vars/index.puml
!include components/index.puml
!include theme/index.puml
!include skinparam/index.puml
!include styles/index.puml
```

If self-registration is the selected project convention, add this once in the entry point:

```plantuml
Register_Theme("Corporate")
```

Otherwise, require consumers to register the included bundle explicitly.

### Naming Rules

- Match the registered name and procedure suffix exactly.
- Prefer names composed of letters and digits, such as `Corporate`, `ProductDark`, or `CustomerA`.
- Avoid spaces, punctuation, and hyphens in registered names.
- Folder names may use repository naming conventions because output files are based on folder names, but the registered procedure suffix must remain a valid, stable PlantUML identifier.

### Composition Guidance

Keep themes focused:

```text
Corporate Theme
    ↓
Product Theme
    ↓
Project Theme
```

A corporate theme should establish broad branding and semantic colors. A product theme should only override product concerns. A project theme should contain the smallest local delta. This avoids monolithic themes and makes reuse practical.

---

## Chapter 7: Framework Extensibility
### Overview

The framework exposes four optional extension procedures so consumers can configure or override behavior without editing core source files:

```plantuml
Preload_Lib_Styles_BEFORE()
Preload_Lib_Styles_AFTER()
Load_Lib_Styles_BEFORE()
Load_Lib_Styles_AFTER()
```

### Processing Order

```text
Preload_Lib_Styles_BEFORE()
    ↓
Preload_Lib_Styles_Stdlib()
    ↓
Preload_Lib_Styles_Togaf()
    ↓
Invoke_Preload_Themes()
    ↓
Preload_Lib_Styles_AFTER()

Load_Lib_Styles_BEFORE()
    ↓
Load_Lib_Styles_Stdlib()
    ↓
Load_Lib_Styles_Togaf()
    ↓
Invoke_Load_Themes()
    ↓
Load_Lib_Styles_AFTER()
```

### Default Implementations

The framework supplies empty defaults:

```plantuml
!procedure Preload_Lib_Styles_BEFORE()
!endprocedure

!procedure Preload_Lib_Styles_AFTER()
!endprocedure

!procedure Load_Lib_Styles_BEFORE()
!endprocedure

!procedure Load_Lib_Styles_AFTER()
!endprocedure
```

Consumers may redefine them before `Load_Lib_Styles_All()` is called.

### Preload Hooks

Preload hooks are for values used when styles are generated.

#### `Preload_Lib_Styles_BEFORE()`

Use this hook to configure the framework before core preload processing:

```plantuml
!procedure Preload_Lib_Styles_BEFORE()
    !$SPACING_UNIT = 8
    !$CONTRAST_THRESHOLD = 140
    !$SKINPARAM_ENABLED = %true()
!endprocedure
```

Typical uses:

- Global sizing and spacing
- Feature flags
- Framework defaults that must exist before core processing
- Variables consumed by core or theme preload procedures

#### `Preload_Lib_Styles_AFTER()`

Use this hook for final variable adjustments after registered themes have run:

```plantuml
!procedure Preload_Lib_Styles_AFTER()
    !$PADDING_TITLE = $SPACING_4
    !$ROUND_CORNER_TITLE = $ROUND_2
!endprocedure
```

Typical uses:

- Final project-level variable overrides
- Derived values based on loaded themes
- Diagram-specific corrections

### Load Hooks

Load hooks emit `<style>` or other style-related PlantUML statements.

#### `Load_Lib_Styles_BEFORE()`

Use this hook for styles that must be emitted before core styles:

```plantuml
!procedure Load_Lib_Styles_BEFORE()
<style>
.projectBase {
    Padding 10
}
</style>
!endprocedure
```

Because core and theme styles load later, they may override these definitions.

#### `Load_Lib_Styles_AFTER()`

Use this hook for final overrides and project stereotypes:

```plantuml
!procedure Load_Lib_Styles_AFTER()
<style>
.projectCard {
    Padding 24
    Margin 12
    RoundCorner 12
    Shadowing true
}

.card {
    Padding 20
}
</style>
!endprocedure
```

This is the preferred hook for local style customization because it runs last.

### Complete Example

```plantuml
@startuml

!procedure Preload_Lib_Styles_BEFORE()
    !$SPACING_UNIT = 8
!endprocedure

!procedure Preload_Lib_Styles_AFTER()
    !$PADDING_TITLE = $SPACING_3
!endprocedure

!procedure Load_Lib_Styles_AFTER()
<style>
.projectCard {
    Padding $SPACING_3
    Margin $SPACING_2
    RoundCorner $ROUND_2
    Shadowing true
}
</style>
!endprocedure

!includeurl MBpuml/all.puml
Load_Lib_Styles_All()

rectangle "Project Component" <<projectCard>>

@enduml
```

> Include order matters. Ensure the framework's empty hook definitions do not overwrite consumer definitions in the PlantUML version and include strategy you support. Test the documented ordering with the compiled bundle.

### Rules of Thumb

| Concern | Hook |
|---|---|
| Configure before core processing | `Preload_Lib_Styles_BEFORE()` |
| Final variable override | `Preload_Lib_Styles_AFTER()` |
| Style emitted before framework styles | `Load_Lib_Styles_BEFORE()` |
| Final style override or project stereotype | `Load_Lib_Styles_AFTER()` |

- Variables belong in preload hooks.
- Styles belong in load hooks.
- BEFORE configures the pipeline.
- AFTER customizes the result.
- Registered theme procedures are separate from consumer extension hooks.

---

## Chapter 8: Utility Stereotypes
### Overview

The standard library offers Bootstrap-inspired utility stereotypes for spacing, borders, rounding, shadows, sizing, and composite containers. Values are variable-driven so themes can change the scale without changing stereotype names.

> PlantUML styles are not a complete CSS cascade. Support and precedence may vary by element type and PlantUML version. Prefer composite stereotypes for production diagrams and test stacked atomic stereotypes in the target renderer.

### Spacing Scale

```plantuml
!$SPACING_UNIT ?= 5
!$SPACING_0 ?= 0
!$SPACING_1 ?= ($SPACING_UNIT * 1)
!$SPACING_2 ?= ($SPACING_UNIT * 2)
!$SPACING_3 ?= ($SPACING_UNIT * 3)
!$SPACING_4 ?= ($SPACING_UNIT * 4)
!$SPACING_5 ?= ($SPACING_UNIT * 6)
```

Override the unit before styles are loaded:

```plantuml
!$SPACING_UNIT = 8
```

### Padding

| Stereotype | Property |
|---|---|
| `<<p0>>` … `<<p5>>` | `Padding` |
| `<<pt0>>` … `<<pt5>>` | `PaddingTop` |
| `<<pb0>>` … `<<pb5>>` | `PaddingBottom` |
| `<<pl0>>` … `<<pl5>>` | `PaddingLeft` |
| `<<pr0>>` … `<<pr5>>` | `PaddingRight` |

```plantuml
rectangle "Padded" <<p3>>
rectangle "Top Padding" <<pt4>>
```

### Margin

| Stereotype | Property |
|---|---|
| `<<m0>>` … `<<m5>>` | `Margin` |
| `<<mt0>>` … `<<mt5>>` | `MarginTop` |
| `<<mb0>>` … `<<mb5>>` | `MarginBottom` |
| `<<ml0>>` … `<<ml5>>` | `MarginLeft` |
| `<<mr0>>` … `<<mr5>>` | `MarginRight` |

```plantuml
rectangle "Margin" <<m2>>
rectangle "Bottom Margin" <<mb3>>
```

Directional properties are renderer-sensitive. Verify them against the PlantUML version used by the distribution pipeline.

### Border Thickness

```plantuml
!$BORDER_0 ?= 0
!$BORDER_1 ?= 1
!$BORDER_2 ?= 2
!$BORDER_3 ?= 3
!$BORDER_4 ?= 4
```

| Stereotype | Effect |
|---|---|
| `<<border0>>` | No line thickness |
| `<<border1>>` | Thin border |
| `<<border2>>` | Medium border |
| `<<border3>>` | Strong border |
| `<<border4>>` | Heavier border |

If `<<border5>>` is emitted, define `$BORDER_5`; otherwise remove the stereotype. The variable and generated styles must remain synchronized.

### Corner Rounding

```plantuml
<<rounded0>>
<<rounded1>>
<<rounded2>>
<<rounded3>>
<<rounded4>>
<<rounded5>>
<<roundedPill>>
<<roundedCircle>>
```

Backed by:

```plantuml
!$ROUND_0 ?= 0
!$ROUND_1 ?= 5
!$ROUND_2 ?= 10
!$ROUND_3 ?= 15
!$ROUND_4 ?= 20
!$ROUND_5 ?= 30
!$ROUND_PILL ?= 50
!$ROUND_CIRCLE ?= 100
```

PlantUML uses an absolute corner radius, so `roundedCircle` does not guarantee a geometrically perfect circle for every element.

### Shadows

```plantuml
<<shadow>>
<<noShadow>>
```

PlantUML exposes shadowing as a boolean. There are no reliable Bootstrap-style small, medium, and large shadow levels.

### Widths

```plantuml
<<wXs>>
<<wSm>>
<<wMd>>
<<wLg>>
<<wXl>>
<<wXxl>>
```

These map to `MinimumWidth`, not percentages. Variables:

```plantuml
!$WIDTH_XS ?= 75
!$WIDTH_SM ?= 150
!$WIDTH_MD ?= 250
!$WIDTH_LG ?= 350
!$WIDTH_XL ?= 500
!$WIDTH_XXL ?= 700
```

### Heights

```plantuml
<<hXs>>
<<hSm>>
<<hMd>>
<<hLg>>
<<hXl>>
```

These map to `MinimumHeight`. Support depends on the rendered element type.

### Cards

Cards are compact visual surfaces with borders, rounding, and shadows.

```plantuml
rectangle "Default Card" <<card>>
rectangle "Compact Card" <<cardCompact>>
rectangle "Large Card" <<cardLg>>
```

| Stereotype | Intended Use |
|---|---|
| `<<card>>` | Default component surface |
| `<<cardCompact>>` | Dense diagrams |
| `<<cardLg>>` | Prominent component or summary |

### Panels

Panels provide stronger grouping, normally without shadows.

```plantuml
package "Default Panel" <<panel>> {
    rectangle "Component" <<card>>
}

package "Compact Panel" <<panelCompact>>
package "Large Panel" <<panelLg>>
```

### Boundaries

```plantuml
rectangle "Architecture Boundary" <<boundary>>
rectangle "Large Boundary" <<boundaryLg>>
```

Use boundaries for architecture scopes, trust boundaries, domains, deployment zones, or system contexts.

### Combining Stereotypes

```plantuml
rectangle "Custom" <<card>><<wLg>><<rounded4>>
```

PlantUML does not provide a full CSS-style merge model. When an atomic utility conflicts with a composite stereotype, precedence can differ by renderer version. Prefer a new composite stereotype when the combination is reused or business-significant.

### Theme Overrides

Theme authors should override variables in their preload procedure:

```plantuml
!procedure Preload_Lib_Styles_THEME_Corporate()
    !$SPACING_UNIT = 8
    !$ROUND_2 = 14
    !$WIDTH_MD = 300
!endprocedure
```

The stereotype API remains unchanged:

```plantuml
rectangle "Themed" <<card>><<wMd>>
```

---

## Chapter 9: Color Resolution
### Overview

The framework resolves style colors through semantic tokens, literal colors, contextual directives, RGB transformations, and contrast evaluation.

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
Final Color
```

This allows diagrams to express intent such as `PRIMARY_DARK`, `AUTO`, or `DARKEN` while themes supply actual colors.

### Supported Values

| Value | Description | Example |
|---|---|---|
| Semantic token | Resolves through `COLOR_<TOKEN>` | `PRIMARY_DARK` |
| Literal color | Used directly | `#023451` |
| `AUTO` | Selects readable text from context | `COLOR_FONT_TITLE = "AUTO"` |
| `CURRENT` | Reuses the current context color | `COLOR_LINE_TITLE = "CURRENT"` |
| `DARKEN` | Semantic promotion, then RGB fallback | `COLOR_LINE_TITLE = "DARKEN"` |
| `DARKEN_n` | RGB fallback by `n` percent | `DARKEN_20` |
| `LIGHTEN` | Semantic promotion, then RGB fallback | `LIGHTEN` |
| `LIGHTEN_n` | RGB fallback by `n` percent | `LIGHTEN_20` |
| `*_TEXT` | Contrast text color for a semantic token | `PRIMARY_DARK_TEXT` |

### Literal Color Formats

```plantuml
#RGB
#RRGGBB
#RRGGBBAA
```

`#RGB` expands to `#RRGGBB`. RGB processing ignores the alpha byte in `#RRGGBBAA` and uses the normalized RGB value.

### Semantic Colors

```plantuml
!$COLOR_PRIMARY ?= "#D6EAF8"
!$COLOR_PRIMARY_DARK ?= "#345678"
```

Then:

```plantuml
BackgroundColor PRIMARY_DARK
```

resolves as:

```text
PRIMARY_DARK
    ↓
COLOR_PRIMARY_DARK
    ↓
#345678
```

Semantic tokens keep diagrams independent from a specific palette.

### Resolver Entry Point

```plantuml
$resolve_style_color($tokenOrColor, $context0, $context1, ...)
```

The resolver selects the first non-special context color and processes directives against it.

Resolution order:

| Priority | Rule |
|---|---|
| 1 | `AUTO` |
| 2 | `CURRENT` |
| 3 | `DARKEN` / `DARKEN_n` |
| 4 | `LIGHTEN` / `LIGHTEN_n` |
| 5 | Literal color |
| 6 | `*_TEXT` token |
| 7 | Semantic color token |

### AUTO

`AUTO` chooses dark or light text according to background luminance.

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY_DARK"
!$COLOR_FONT_TITLE = "AUTO"
```

Conceptual result:

```text
PRIMARY_DARK
    ↓
Literal background
    ↓
Luminance comparison
    ↓
COLOR_TEXT or COLOR_TEXT_LIGHT
```

Configuration:

```plantuml
!$CONTRAST_THRESHOLD ?= 128
```

Rule:

```text
Luminance ≤ threshold → light text
Luminance > threshold → dark text
```

### CURRENT

`CURRENT` returns the nearest usable context color:

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY"
!$COLOR_LINE_TITLE = "CURRENT"
```

The line resolves to the title background color.

`CURRENT` without context is an error. A context that recursively resolves to `CURRENT` is also rejected.

### Semantic Progression

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

#### DARKEN

```text
PRIMARY_LIGHT   → PRIMARY
PRIMARY         → PRIMARY_DARK
PRIMARY_DARK    → PRIMARY_DARKEST
PRIMARY_DARKEST → RGB darkening fallback
```

#### LIGHTEN

```text
PRIMARY_DARKEST  → PRIMARY_DARK
PRIMARY_DARK     → PRIMARY
PRIMARY          → PRIMARY_LIGHT
PRIMARY_LIGHT    → PRIMARY_LIGHTEST
PRIMARY_LIGHTEST → RGB lightening fallback
```

Plain `DARKEN` and `LIGHTEN` prefer semantic promotion. Percentage forms determine the RGB fallback percentage when semantic promotion is unavailable.

### RGB Transformations

Defaults:

```plantuml
!$DARKEN_DEFAULT_PERCENT = 5
!$LIGHTEN_DEFAULT_PERCENT = 5
```

Examples:

```plantuml
$resolve_style_color("DARKEN_20", "PRIMARY")
$resolve_style_color("LIGHTEN_30", "PRIMARY_DARK")
```

### Transformation Safety

```plantuml
!$DARKNESS_THRESHOLD = 32
!$LIGHTNESS_THRESHOLD = 223
```

The normalization helpers keep transformed colors from becoming excessively close to pure black or white. They apply a proportional correction followed by bounded one-percent adjustments to account for integer rounding.

These thresholds affect transformations, not whether literal black or white may be defined as a theme value.

### Contrast Calculation

The implementation uses an integer luminance approximation:

```text
(299 × R + 587 × G + 114 × B) / 1000
```

The result ranges from 0 to 255.

### Examples

#### Automatic Text and Current Border

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY_DARK"
!$COLOR_FONT_TITLE = "AUTO"
!$COLOR_LINE_TITLE = "CURRENT"
```

```text
BackgroundColor = PRIMARY_DARK
FontColor       = contrast text for PRIMARY_DARK
LineColor       = PRIMARY_DARK
```

#### Semantic Darkening

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY"
!$COLOR_LINE_TITLE = "DARKEN"
```

If `COLOR_PRIMARY_DARK` exists, the line uses it.

#### RGB Fallback

```plantuml
!$COLOR_BACKGROUND_TITLE = "PRIMARY_DARKEST"
!$COLOR_LINE_TITLE = "DARKEN_20"
```

If no darker semantic token exists, the literal color is darkened and normalized against the darkness floor.

### Validation

Literal colors are validated before channel extraction. Invalid values fail with an assertion such as:

```text
MB_UML :: Invalid literal color=[#GGGGGG]
```

Semantic variable names are normalized to uppercase `COLOR_` names. Undefined variables fail when strict resolution is requested.

### Theme Authoring Recommendations

- Define semantic colors as valid hex values.
- Provide coherent LIGHT, BASE, DARK, and optional LIGHTEST/DARKEST variants.
- Use semantic tokens in styles rather than theme-specific literals.
- Use `AUTO` only where a background context is supplied.
- Test contrast and transformations with the exact PlantUML version used in production.

---
## Chapter 10: Text Utilities

### Overview

The Text Utilities library provides reusable formatting helpers for generating consistent textual content throughout the framework.

Typical use cases include:

- Diagram titles
- Notes
- Legends
- Diagnostic output
- Generated documentation
- Build metadata
- Framework-generated content

The utilities are intentionally lightweight and prioritize maximum PlantUML compatibility.

The implementation uses only broadly supported preprocessor features and avoids collection and iteration constructs that may vary across PlantUML versions.

### Design Goals

The Text Utilities library was designed to:

1. Produce predictable rendering across PlantUML runtimes.
2. Eliminate repeated string-formatting logic.
3. Encourage consistent spacing and layout conventions.
4. Simplify generation of titles, notes, legends, and documentation content.
5. Provide higher-level formatting abstractions built on simple primitives.
6. Avoid dependency on advanced or version-sensitive PlantUML features.

### Formatting Model

PlantUML generally renders whitespace more consistently when horizontal padding exists **inside** vertical spacing boundaries.

Preferred:

```text

    TEXT

```

Instead of:

```text

TEXT

```

For this reason, the library promotes framed-content helpers such as:

```plantuml
$surround()
```

and

```plantuml
$framed_title()
```

over manual combinations of spacing functions.

Consumers should prefer expressing formatting intent through reusable helpers rather than embedding literal spacing within diagrams.

---

### Utility Categories

The module is organized into three groups.

| Category | Purpose |
|---|---|
| Primitive Utilities | String generation and repetition |
| Horizontal Formatting | Padding and alignment |
| Vertical Formatting | Line spacing and framing |

---

### Primitive Utilities

Primitive utilities provide the basic building blocks used by higher-level formatting functions.

#### Repeat Text

```plantuml
$repeat("-",10)
```

Result:

```text
----------
```

#### Generate New Lines

```plantuml
$nl(2)
```

Result:

```text
<newline>
<newline>
```

Most consumers should not use these primitives directly unless authoring new formatting utilities.

---

### Horizontal Formatting

Horizontal formatting utilities control spacing around text.

#### Left Padding

```plantuml
$pad_left("Title",4)
```

Result:

```text
    Title
```

#### Right Padding

```plantuml
$pad_right("Title",4)
```

Result:

```text
Title
```

#### Symmetric Padding

```plantuml
$pad_both("Title",4)
```

Result:

```text
    Title
```

#### Centering

```plantuml
$center_text(
    "Architecture Overview",
    60
)
```

Result:

```text
                   Architecture Overview
```

Centering is intended for visual alignment rather than exact monospaced positioning.

---

### Vertical Formatting

Vertical formatting utilities control line spacing around content.

#### Add Lines Above

```plantuml
$line_above("Heading")
```

#### Add Lines Below

```plantuml
$line_below("Heading")
```

#### Add Lines Above and Below

```plantuml
$line_wrap("Heading")
```

These helpers are useful when constructing larger text blocks, but most diagram content should use framed-content helpers instead.

---

### Framed Content

#### Surround

`$surround()` is the preferred helper for notes, legends, generated content, and diagnostic output.

It combines:

- Vertical spacing
- Horizontal spacing
- Internal padding

Example:

```plantuml
$surround("Architecture Overview")
```

Result:

```text

    Architecture Overview

```

The helper automatically applies spacing using the library's preferred rendering model.

Additional spacing can be configured:

```plantuml
$surround(
    "CONFIDENTIAL",
    8,
    2
)
```

Result:

```text


        CONFIDENTIAL


```

---

### Diagram Titles

#### Framed Title

`$framed_title()` is the preferred helper for formatting diagram titles.

It combines:

- Centering
- Horizontal padding
- Vertical spacing

Example:

```plantuml
title $framed_title(
    "Architecture Overview"
)
```

A custom width and spacing may also be supplied:

```plantuml
title $framed_title(
    "Logical Component View",
    80,
    4,
    2
)
```

Consumers should prefer `framed_title()` over manually composing centering and spacing helpers.

---

### Common Usage Patterns

#### Diagram Title

```plantuml
title $framed_title(
    "Logical Component View"
)
```

#### Note Header

```plantuml
note

$surround("Design Notes")

All requests are validated before processing.

end note
```

#### Legend Header

```plantuml
legend

$surround("Legend")

|= Type |= Description |
| Component | Service |

endlegend
```

#### Section Separator

```plantuml
note

$line_wrap("-----------------------------------")

end note
```

#### Diagnostic Output

```plantuml
note

$center_text(
    "BUILD INFORMATION",
    60
)

end note
```

---

### Best Practices

- Prefer `$surround()` for framed content.
- Prefer `$framed_title()` for diagram titles.
- Use primitive helpers only when authoring new formatting utilities.
- Express formatting intent through reusable functions rather than embedding literal whitespace.
- Apply a consistent formatting approach across diagrams, themes, and generated documentation.
- Keep generated content readable and deterministic by reusing framework-provided helpers.

---


## Chapter 11: Troubleshooting
### Invalid Literal Color

#### Symptom

```text
MB_UML :: Invalid literal color=[#GGGGGG]
```

#### Cause

The value is not valid `#RGB`, `#RRGGBB`, or `#RRGGBBAA` hexadecimal notation.

#### Resolution

```plantuml
#FFF
#FFFFFF
#FFFFFF00
```

Named colors and `rgb(...)` syntax are not accepted by RGB helper functions unless explicitly resolved before use.

### Undefined Semantic Color

#### Symptom

```text
MB_UML :: Invalid variable name or undefined variable=[$COLOR_PRIMARY_DARKEST]
```

#### Cause

A semantic token was used without a corresponding variable.

#### Resolution

Define it:

```plantuml
!$COLOR_PRIMARY_DARKEST = "#012345"
```

or use an existing token.

### AUTO Requires Context

#### Symptom

```text
MB_UML :: AUTO (resolve_style_color) requires a context color
```

#### Resolution

```plantuml
$resolve_style_color("AUTO", "PRIMARY_DARK")
```

In generated styles, resolve the background first and pass it as context for font color.

### CURRENT Requires Context

#### Symptom

```text
MB_UML :: CURRENT (resolve_style_color) requires a context color to determine CURRENT
```

#### Resolution

```plantuml
$resolve_style_color("CURRENT", "PRIMARY")
```

Do not provide `CURRENT` as its own context.

### DARKEN or LIGHTEN Requires Context

#### Symptom

```text
MB_UML :: DARKEN (resolve_style_color) requires a context color
```

or:

```text
MB_UML :: LIGHTEN (resolve_style_color) requires a context color
```

#### Resolution

```plantuml
$resolve_style_color("DARKEN", "PRIMARY")
$resolve_style_color("LIGHTEN", "PRIMARY_DARK")
```

### Invalid Hex Byte or Digit

#### Symptom

```text
MB_UML :: Invalid hex byte=[ABCD]
```

or:

```text
MB_UML :: Invalid hex digit=[G]
```

#### Cause

A malformed value reached RGB processing, often through an incorrectly defined semantic variable.

#### Resolution

Trace the semantic token to its variable and ensure it resolves to valid hex.

### Invalid Variable Name

#### Cause

Framework helper functions expect uppercase PlantUML variable names, with or without the leading dollar sign.

Valid:

```text
COLOR_PRIMARY
$COLOR_PRIMARY
```

Invalid:

```text
$Color_Primary
$$COLOR_PRIMARY
```

### Theme Procedure Invocation Fails

#### Cause

The registry builds procedure names dynamically. A registered theme must define both procedures with exact casing:

```plantuml
Preload_Lib_Styles_THEME_Corporate()
Load_Lib_Styles_THEME_Corporate()
```

for:

```plantuml
Register_Theme("Corporate")
```

PlantUML does not provide a portable procedure-existence check before `%invoke_procedure()`.

#### Resolution

- Verify the theme bundle was included before registration.
- Verify the registered name exactly matches the procedure suffix.
- Verify both preload and load procedures exist, even if one is empty.

### Theme Was Included but Not Applied

Check the complete sequence:

```plantuml
!includeurl MBpuml/all.puml
!includeurl MBpuml/theme-corporate.puml
Register_Theme("Corporate")
Load_Lib_Styles_All()
```

Including a bundle defines its procedures; registration makes it part of the loader; `Load_Lib_Styles_All()` executes the pipeline.

### Theme Executed Twice

Use the guarded registry implementation so `Register_Theme()` ignores duplicate names. Also choose either self-registration or consumer registration, not both.

### Include Inside Procedure Does Not Behave Dynamically

`!include` is a static preprocessing mechanism. The registry can control execution only after files are included. Put includes in the theme entry point, not inside preload/load procedures.

### Unexpected Utility Style Result

PlantUML does not implement a full CSS cascade. Stacked stereotypes can conflict or vary by element type.

#### Resolution

- Test against the production PlantUML version.
- Prefer `<<card>>`, `<<panel>>`, or another composite.
- Create a project composite when a combination is reused.
- Confirm directional padding, margin, and minimum-height support for the element type.

### Undefined `$BORDER_5`

If styles emit:

```plantuml
.border5 { LineThickness $BORDER_5 }
```

then variables must define:

```plantuml
!$BORDER_5 ?= 5
```

Otherwise remove `border5`. Generated style definitions and variable inventories must remain synchronized.

### Unexpected AUTO Text Color

Inspect luminance and threshold:

```plantuml
!log $hex_luminance("#345678")
!log $get_auto_text_color("#345678")
```

Adjust only after checking accessibility and the full palette:

```plantuml
!$CONTRAST_THRESHOLD = 140
```

### Transformation Threshold Errors

Thresholds must be between 0 and 255:

```plantuml
!$DARKNESS_THRESHOLD = 32
!$LIGHTNESS_THRESHOLD = 223
```

Darken and lighten percentages must be between 0 and 100.

### Build Does Not Discover Themes

The build must point to the actual source folder:

```bash
THEMES_DIR="src/themes"
```

Each immediate child folder must contain:

```text
src/themes/<folder-name>/index.puml
```

Add diagnostics:

```bash
printf 'Theme root: %s\n' "$THEMES_DIR"
find "$THEMES_DIR" -type f -name index.puml -print
```

The expected output name is:

```text
theme-<folder-name>.puml
```

### AWK Unexpected Newline

AWK does not accept a bare assignment split across lines:

```awk
property_list[block_name] =
    property_list[block_name] prop "\n"
```

Use one line or an explicit continuation:

```awk
property_list[block_name] = property_list[block_name] prop "\n"
```

### Diagnostic Helpers

Simple diagnostic output can be produced directly using PlantUML logging functions.

Examples:

```plantuml
!log $is_literal_color("#345678")
!log $hex_red("#345678")
!log $hex_green("#345678")
!log $hex_blue("#345678")
!log $hex_luminance("#345678")
!log $get_auto_text_color("#345678")
!log $resolve_style_color("AUTO", "PRIMARY_DARK")
!log $Is_Theme_Registered("Corporate")
```

These diagnostics are useful for validating assumptions during development and troubleshooting.

For more advanced runtime inspection, framework diagnostics, variable inspection, and color debugging, see:

```text
Chapter 12: Debugging and Diagnostics
```

The debugging utilities provide reusable helpers for inspecting:

- Variables and resolved values
- Style and color resolution
- Theme execution
- Runtime configuration
- Generated framework output

Use diagnostics temporarily during investigation and remove them from production diagrams unless intentionally documenting framework behavior.

---

### Troubleshooting Workflow

When troubleshooting framework behavior, the recommended progression is:

```text
Observe the Symptom
    ↓
Review the Relevant Error Message
    ↓
Validate Theme Registration
    ↓
Validate Variable Values
    ↓
Validate Color Resolution
    ↓
Use Debugging Utilities
    ↓
Apply the Resolution
```

For runtime inspection of variables, colors, and generated content, use the diagnostics described in:

```text
Chapter 12: Debugging and Diagnostics
```

---
