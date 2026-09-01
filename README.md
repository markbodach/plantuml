# Architecture Diagrams

This repository contains the PlantUML source, reusable themes, libraries, and generated architecture views for solution architecture.

The repository is organized to support consistent architecture modeling aligned with TOGAF architecture viewpoints, architecture traceability, and enterprise architecture governance practices.

## Objectives

The repository provides:

- A single source of truth for architecture diagrams.
- Consistent styling and notation across all views.
- Reusable architecture libraries and patterns.
- Traceability from architecture patterns through implementation technologies.
- Version-controlled architecture assets suitable for architecture review and governance.

## Architecture Modeling Principles

The architecture diagrams in this repository follow these principles:

- Architecture views describe logical, deployment, information, and traceability concerns independently.
- Architecture patterns are modeled separately from implementation components.
- Solution Building Blocks (SBBs) represent reusable solution capabilities.
- Logical Components represent application architecture.
- Deployment Components represent runtime workloads.
- Technology Products represent technology implementations.
- Color, shape, and notation are applied consistently through shared themes and libraries.

## Repository Structure

```text
/
├── README.md
│
├── themes/
│   ├── oh-theme.puml
│   ├── togaf-theme.puml
│
├── libraries/
│   ├── patterns.puml
│   ├── sbbs.puml
│   ├── togaf-business.puml
│   ├── togaf-logical.puml
│   ├── togaf-deployment.puml
│   ├── togaf-technology.puml
│
├── diagrams/
│   ├── capability/
│   ├── logical/
│   ├── deployment/
│   ├── information/
│   ├── traceability/
│   ├── patterns/
│
├── generated/
│   ├── png/
│   ├── svg/
│
└── docs/
    ├── architecture-standards.md
    ├── diagram-guidelines.md
```

## Theme Usage

All diagrams should include the shared theme.

```plantuml
@startuml

!include ../themes/panelapp-theme.puml

@enduml
```

The theme provides:

- Color standards
- Font standards
- Border standards
- Layout standards
- Architecture stereotypes
- Reusable legend definitions



## Generating Diagrams

Generate PNG output:

```bash
plantuml diagram.puml
```

Generate SVG output:

```bash
plantuml -tsvg diagram.puml
```

Generate all diagrams:

```bash
find diagrams -name "*.puml" -exec plantuml {} \;
```
