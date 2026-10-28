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

* Generated on: **2026-10-28 11:27:20 EDT**
* Build Commit Hash: **08434a5796c67049b31ecbca218cd4f5e47970aa**
* Build Commit Comment: **Pound tracing**

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

