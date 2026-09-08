
# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* **Compiled Bundle:** `all.puml`
* **Generated on:** 2026-09-08 14:54:20 EDT

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

```plantuml
@startuml

' Archimate and TOGAF
!define MBOHPuml https://raw.githubusercontent.com/markbodach/plantuml/refs/heads/main/dist
includeurl MBOHPuml/all.puml


' Your custom components are now available globally!
MyCustomDatabase(db1, "User Database")
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
        └── _skinparam.puml
      └── togaf/index.puml
        └── _colors.puml
        └── _fonts.puml
      └── ontario-health/index.puml
        └── _colors.puml
        └── _fonts.puml
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

- A single source of truth for architecture diagrams.
- Consistent styling and notation across all views.
- Reusable architecture libraries and patterns.
- Traceability from architecture patterns through implementation technologies.
- Version-controlled architecture assets suitable for architecture review and governance.

