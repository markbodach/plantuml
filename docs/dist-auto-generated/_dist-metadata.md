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

* Generated on: **2026-10-23 12:00:59 EDT**
* Build Commit Hash: **c7e4dd3497e5dfca57188b95d8c1c5e1d2278204**
* Build Commit Comment: **Code is architecturally sound. Registry abstraction is complete. Constant-based registry identifiers eliminate string literal drift. Further refactoring would produce diminishing returns. Focus effort on updating framework documentation and extension-authoring guidance rather than changing implementation**

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

