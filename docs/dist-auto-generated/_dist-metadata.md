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

* Generated on: **2026-11-27 14:21:14 EST**
* Build Commit Hash: **2b933b1bab603ddf1530f9c8c75892119ad00407**
* Build Commit Comment: **diagram layout model**

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

