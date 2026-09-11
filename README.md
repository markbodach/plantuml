
# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* Compiled Bundle: **`all.puml`**
* Generated on: **2026-09-11 11:29:28 EDT**
* Build Commit Hash: **9a51bbc38855bea5068c7ad0b9782801f296d1b3**
* Build Commit Comment: **added Build Commit information**

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
LoadThemeStyles_All()

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
!$COLOR_BORDER = "#5D6D7E"
!$COLOR_BUSINESS = $COLOR_WARNING
!$COLOR_DEPLOYMENT = "#FAD7A0"
!$COLOR_ERROR_DARK = "Red"
!$COLOR_ERROR_LIGHT = "Red"
!$COLOR_ERROR = "Red"
!$COLOR_EXTERNAL = "#E8DAEF"
!$COLOR_LOGICAL = $COLOR_PRIMARY
!$COLOR_NONE = $COLOR_TRANSPARENT
!$COLOR_PRIMARY_DARK = "#D6EAF8"
!$COLOR_PRIMARY_LIGHT = "#D6EAF8"
!$COLOR_PRIMARY = "#D6EAF8"
!$COLOR_SUCCESS_DARK = "#D5F5E3"
!$COLOR_SUCCESS_LIGHT = "#D5F5E3"
!$COLOR_SUCCESS = "#D5F5E3"
!$COLOR_TECHNOLOGY = $COLOR_SUCCESS
!$COLOR_TEXT = "#000000"
!$COLOR_WARNING_DARK = "#FCF3CF"
!$COLOR_WARNING_LIGHT = "#FCF3CF"
!$COLOR_WARNING = "#FCF3CF"
!$DEFAULT_TEXT_ALIGNMENT = "center"
!$FONT_COLOR_TITLE = $COLOR_PRIMARY
!$FONT_COLOR = $COLOR_TEXT
!$FONT_NAME = "Segoe UI"
!$FONT_SIZE_ARROW = 11
!$FONT_SIZE_LEGEND = 11
!$FONT_SIZE_TITLE = 18
!$FONT_SIZE = 12
!$FONT_STYLE_TITLE = "bold"
!$HORIZONTAL_ALIGNMENT_TITLE = "center"
!$LINE_COLOR_TITLE = $LINE_COLOR
!$LINE_SIZE_TITLE = $LINE_SIZE
!$LINETYPE = "ortho"
!$MARGIN_TITLE = 20
!$MARGIN = 15
!$NODE_SEP = 75
!$OH_THEME_ENABLED = %true()
!$PADDING_TITLE = 15
!$PADDING = 10
!$RANK_SEP = 75
!$RECTANGLE_BORDER_COLOR = $COLOR_NONE
!$ROUND_CORNER_TITLE = $ROUND_CORNER
!$ROUND_CORNER = 10
!$SHADOWING = %false()
!$TOGAF_THEME_ENABLED = %true()

@enduml
```

# All Defined PlantUML skinparam Variables
This list is generated from the repository's puml source code.  Skin parameters can be re-initialized after including the repository.  

```plantuml
@startuml

skinparam shadowing $SHADOWING
skinparam linetype $LINETYPE
skinparam defaultTextAlignment $DEFAULT_TEXT_ALIGNMENT
skinparam nodesep $NODE_SEP
skinparam ranksep $RANK_SEP
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
    └── themes/index.puml
      └── common/index.puml
        └── _colors.puml
        └── _fonts.puml
        └── _borders.puml
        └── _layout.puml
        └── _icons.puml
        └── _title.puml
        └── _skinparam.puml
      └── togaf/index.puml
        └── _colors.puml
        └── _fonts.puml
      └── ontario-health/index.puml
        └── _colors.puml
        └── _fonts.puml
      └── common/styles/index.puml
      └── togaf/styles/index.puml
      └── ontario-health/styles/index.puml
    └── libraries/index.puml
      └── stdlib/index.puml
      └── togaf/index.puml
        └── _functions.puml
        └── _business.puml
        └── _logical.puml
        └── _deployment.puml
        └── _technology.puml
      └── ontario-health/index.puml
        └── _patterns.puml
        └── _sbbs.puml
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

