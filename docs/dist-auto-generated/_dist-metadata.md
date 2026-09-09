# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* **Compiled Bundle:** `all.puml`
* **Generated on:** 2026-09-09 11:53:02 EDT

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

```plantuml
@startuml

' Archimate and TOGAF
!define MBOHPuml https://markbodach.github.io/plantuml
includeurl MBOHPuml/all.puml


' Your custom components are now available globally!
MyCustomDatabase(db1, "User Database")
@enduml
```

