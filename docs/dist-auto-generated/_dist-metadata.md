# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* **Compiled Bundle:** `all.puml`
* **Generated on:** 2026-09-10 15:49:34 EDT

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

```plantuml
@startuml

!$OH_THEME_ENABLED = %true()
!$TOGAF_THEME_ENABLED = %true()

' Archimate and TOGAF
!define MBpuml https://markbodach.github.io/plantuml/
!includeurl MBpuml/all.puml


' Your custom components are now available globally!
'MyCustomDatabase(db1, "User Database")
@enduml
```

