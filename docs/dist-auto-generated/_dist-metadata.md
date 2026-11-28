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

* Generated on: **2026-11-28 11:01:00 EST**
* Build Commit Hash: **438df8ecc3cb2d55deac0430d65cff74799bb367**
* Build Commit Comment: **dlm update 6**

## Usage

```plantuml
@startuml

!define MBpuml https://markbodach.github.io/plantuml

!includeurl MBpuml/all.puml

!includeurl MBpuml/theme-corporate.puml

Register_Lib_All("Corporate")

Load_Lib_All()

@enduml
```

