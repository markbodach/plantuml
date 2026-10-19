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

* Generated on: **2026-10-19 14:29:24 EDT**
* Build Commit Hash: **c35f6c00a60017a14471ffda8e773887dbec6d9a**
* Build Commit Comment: **ArchiMate border colors**

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

