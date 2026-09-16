
# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* Compiled Bundle: **`all.puml`**
* Generated on: **2026-09-16 06:38:03 EDT**
* Build Commit Hash: **04d09e03faf3fb3c52a9eed8e49c76baf6ec3dc6**
* Build Commit Comment: **Refactored color functions**

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

```plantuml
@startuml

' STEP 1 :: Enable the themes to be used
!$OH_THEME_ENABLED = %true()
!$TOGAF_THEME_ENABLED = %true()

' STEP 2 :: Load the Archimate and TOGAF library
!define MBpuml https://markbodach.github.io/plantuml/
!includeurl MBpuml/all.puml

' STEP 3 :: Apply the global styling - only the enabled themes will have styles applied
Load_Lib_Styles_All()

@enduml
```

# All Override PlantUML Variables
This list is generated from the repository's puml source code.  Use these variables before loading the repository.  

```plantuml
@startuml

!$ACTOR_BACKGROUND_COLOR = "#90CAF9"
!$ACTOR_BORDER_COLOR = "#0D47A1"
!$ACTOR_BORDER_SIZE = 3
!$ACTOR_STYLE = awesome
!$BACKGROUND_COLOR_TITLE = $COLOR_PRIMARY_LIGHT
!$BORDER_THICKNESS_BOLD = 2
!$BORDER_THICKNESS_POD = 2
!$BORDER_THICKNESS = 1
!$COLOR_APPLICATION_DARK = $TOGAF_COLOR_APPLICATION
!$COLOR_APPLICATION_LIGHT = $TOGAF_COLOR_APPLICATION
!$COLOR_BODY = "#ffffff"
!$COLOR_BORDER = "#5D6D7E"
!$COLOR_BUSINESS_DARK = $TOGAF_COLOR_BUSINESS
!$COLOR_BUSINESS_LIGHT = $TOGAF_COLOR_BUSINESS
!$COLOR_ERROR_DARK = "#CD0000"
!$COLOR_ERROR_LIGHT = "#CD0000"
!$COLOR_ERROR = "#CD0000"
!$COLOR_HIGHLIGHTED_DARK = $TOGAF_COLOR_HIGHLIGHTED
!$COLOR_HIGHLIGHTED_LIGHT = $TOGAF_COLOR_HIGHLIGHTED
!$COLOR_IMPLEMENTATION_DARK = $TOGAF_COLOR_IMPLEMENTATION
!$COLOR_IMPLEMENTATION_LIGHT = $TOGAF_COLOR_IMPLEMENTATION
!$COLOR_MOTIVATION_DARK = $TOGAF_COLOR_MOTIVATION
!$COLOR_MOTIVATION_LIGHT = $TOGAF_COLOR_MOTIVATION
!$COLOR_NEW_DARK = $TOGAF_COLOR_NEW
!$COLOR_NEW_LIGHT = $TOGAF_COLOR_NEW
!$COLOR_NONE = $COLOR_TRANSPARENT
!$COLOR_PRIMARY_DARK = "#D6EAF8"
!$COLOR_PRIMARY_LIGHT = "#D6EAF8"
!$COLOR_PRIMARY = "#D6EAF8"
!$COLOR_STRATEGY_DARK = $TOGAF_COLOR_STRATEGY
!$COLOR_STRATEGY_LIGHT = $TOGAF_COLOR_STRATEGY
!$COLOR_SUCCESS_DARK = "#D5F5E3"
!$COLOR_SUCCESS_LIGHT = "#D5F5E3"
!$COLOR_SUCCESS = "#D5F5E3"
!$COLOR_TECHNOLOGY_DARK = $TOGAF_COLOR_TECHNOLOGY
!$COLOR_TECHNOLOGY_LIGHT = $TOGAF_COLOR_TECHNOLOGY
!$COLOR_TEXT_LIGHT = $COLOR_BODY
!$COLOR_TEXT = "#000000"
!$COLOR_WARNING_DARK = "#FCF3CF"
!$COLOR_WARNING_LIGHT = "#FCF3CF"
!$COLOR_WARNING = "#FCF3CF"
!$DEFAULT_TEXT_ALIGNMENT = "center"
!$FONT_COLOR_TITLE = $FONT_COLOR
!$FONT_COLOR = $COLOR_TEXT
!$FONT_NAME = "Segoe UI"
!$FONT_SIZE_ARROW = 11
!$FONT_SIZE_LEGEND = 11
!$FONT_SIZE_TITLE = 18
!$FONT_SIZE = 12
!$FONT_STYLE_TITLE = "bold"
!$HORIZONTAL_ALIGNMENT_TITLE = "center"
!$LINE_COLOR_TITLE = $LINE_COLOR
!$LINE_COLOR = $COLOR_TEXT
!$LINE_SIZE_TITLE = $LINE_SIZE
!$LINE_SIZE = 2
!$LINE_TYPE = "ortho"
!$MARGIN_TITLE = 20
!$MARGIN = 15
!$NODE_SEP = 75
!$OH_COLOR_APPLICATION_DARK = "#3193CC"
!$OH_COLOR_APPLICATION_LIGHT = "#C5EEFA"
!$OH_COLOR_BORDER = "#5D6D7E"
!$OH_COLOR_BUSINESS_DARK = "#FFD440"
!$OH_COLOR_BUSINESS_LIGHT = "#FFFDC4"
!$OH_COLOR_BUSINESS = $OH_COLOR_WARNING
!$OH_COLOR_DEPLOYMENT = "#FAD7A0"
!$OH_COLOR_DISABLED_MILD = "#737373"
!$OH_COLOR_ERROR_DARK = "#8a0101"
!$OH_COLOR_ERROR_LIGHT = "#FCEFF0"
!$OH_COLOR_ERROR = "#CD0000"
!$OH_COLOR_EXTERNAL = "#E8DAEF"
!$OH_COLOR_HIGHLIGHTED_DARK = "#0050EF"
!$OH_COLOR_HIGHLIGHTED_LIGHT = "#CFEDED"
!$OH_COLOR_IMPLEMENTATION_DARK = "#F15A22"
!$OH_COLOR_IMPLEMENTATION_LIGHT = "#FEE1D9"
!$OH_COLOR_LABEL = "#4D4D4D"
!$OH_COLOR_LOGICAL = $OH_COLOR_PRIMARY
!$OH_COLOR_MOTIVATION_DARK = "#B975B7"
!$OH_COLOR_MOTIVATION_LIGHT = "#F1E3F2"
!$OH_COLOR_NEW_DARK = "#005700"
!$OH_COLOR_NEW_LIGHT = "#DDEDC7"
!$OH_COLOR_PLACEHOLDER = "#737373"
!$OH_COLOR_PRIMARY_DARK = "#023451"
!$OH_COLOR_PRIMARY_LIGHT = "#D6EAF8"
!$OH_COLOR_PRIMARY = "#047BC1"
!$OH_COLOR_STRATEGY_DARK = "#EFB243"
!$OH_COLOR_STRATEGY_LIGHT = "#F8E5C3"
!$OH_COLOR_SUCCESS_DARK = "#0F7C41"
!$OH_COLOR_SUCCESS_LIGHT = "#EAF5EA"
!$OH_COLOR_SUCCESS = "#118847"
!$OH_COLOR_TECHNOLOGY_DARK = "#39B54A"
!$OH_COLOR_TECHNOLOGY_LIGHT = "#D1EFD4"
!$OH_COLOR_TECHNOLOGY = $OH_COLOR_SUCCESS
!$OH_COLOR_TEXT = "#1A1A1A"
!$OH_COLOR_WARNING_DARK = "#FFFAEB"
!$OH_COLOR_WARNING_LIGHT = "#EFB243"
!$OH_COLOR_WARNING = "#FCAF17"
!$OH_THEME_ENABLED = %false()
!$PADDING_TITLE = 15
!$PADDING = 10
!$RANK_SEP = 75
!$RECTANGLE_BORDER_COLOR = $COLOR_NONE
!$ROUND_CORNER_TITLE = $ROUND_CORNER
!$ROUND_CORNER = 10
!$SHADOWING = %false()
!$SKINPARAM_ENABLED = %false()
!$TOGAF_COLOR_APPLICATION = "#99FFFF"
!$TOGAF_COLOR_BUSINESS = "#FFFF99"
!$TOGAF_COLOR_HIGHLIGHTED = "#005DEF"
!$TOGAF_COLOR_IMPLEMENTATION = "#FFE0E0"
!$TOGAF_COLOR_MOTIVATION = "#CCCCFF"
!$TOGAF_COLOR_NEW = "#005700"
!$TOGAF_COLOR_STRATEGY = "#F5DEAA"
!$TOGAF_COLOR_TECHNOLOGY = "#AFFFAF"
!$TOGAF_THEME_ENABLED = %false()

@enduml
```

# All Defined PlantUML skinparam Variables
This list is generated from the repository's puml source code.  Skin parameters can be re-initialized after including the repository.  

```plantuml
@startuml

skinparam linetype $LINE_TYPE
skinparam nodesep $NODE_SEP
skinparam ranksep $RANK_SEP
skinparam shadowing $SHADOWING
skinparam defaultTextAlignment $DEFAULT_TEXT_ALIGNMENT
skinparam rectangleBorderColor $RECTANGLE_BORDER_COLOR
skinparam actorStyle $ACTOR_STYLE
skinparam actorBorderColor $ACTOR_BORDER_COLOR
skinparam actorBorderThickness $ACTOR_BORDER_SIZE
skinparam actorBackgroundColor $ACTOR_BACKGROUND_COLOR

@enduml
```

## 📦 Bundled  Repository Tree
This tree maps out exactly how the source code files were evaluated and sequenced into this final `all.puml` production asset:

```text
src/all.puml (Root Master)
  └── index.puml
    └── libs/index.puml
      └── stdlib/vars/index.puml
        └── _index.puml
        └── _colors.puml
        └── _fonts.puml
        └── _borders.puml
        └── _layout.puml
        └── _icons.puml
        └── _title.puml
      └── togaf/vars/index.puml
        └── _index.puml
        └── _colors.puml
        └── _fonts.puml
      └── ontario-health/vars/index.puml
        └── _index.puml
        └── _colors.puml
        └── _fonts.puml
        └── _layout.puml
        └── _title.puml
      └── stdlib/components/index.puml
        └── _variables.puml
        └── _colors.puml
      └── togaf/components/index.puml
        └── _functions.puml
        └── _colors.puml
      └── ontario-health/components/index.puml
        └── _title.puml
        └── _patterns.puml
        └── _sbbs.puml
      └── stdlib/theme/index.puml
      └── togaf/theme/index.puml
      └── ontario-health/theme/index.puml
      └── stdlib/skinparam/index.puml
      └── togaf/skinparam/index.puml
      └── ontario-health/skinparam/index.puml
      └── stdlib/styles/index.puml
        └── _title.puml
      └── togaf/styles/index.puml
      └── ontario-health/styles/index.puml
        └── _title.puml
```

# Architecture Diagrams

This repository contains the PlantUML source for:
* reusable themes
* libraries
* architecture views 
for solution architecture.

The repository is organized to support consistent architecture modeling aligned with TOGAF / ArchiMate architecture viewpoints.

Theme Variables 
↓ 
Skinparam Initialization 
↓ 
TOGAF Theme Mapping 
↓ 
Ontario Health Theme Overlay 
↓ 
Reusable Libraries 
↓ 
Diagram Consumption

## Architecture Modeling Principles

The architecture diagrams in this repository follow these principles:

- Architecture views describe logical, deployment, information, and traceability concerns independently.
- Architecture patterns are modeled separately from implementation components.
- Solution Building Blocks (SBBs) represent reusable solution capabilities.
- Logical Components represent application architecture.
- Deployment Components represent runtime workloads.
- Technology Products represent technology implementations.
- Color, shape, and notation are applied consistently through shared themes and libraries.

## Objectives

The repository provides:

- A single source of truth for architecture diagrams colour and styling aligned with Ontario Health's Design System.
- Consistent styling and notation across all views.
- Reusable architecture libraries and patterns.
- Version-controlled architecture assets suitable for architecture review and governance.

