# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* **Compiled Bundle:** `all.puml`
* **Generated on:** 2026-09-09 15:46:41 EDT

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

```plantuml
@startuml

&excl;&dollar;OH_THEME_ENABLED = %true()
&excl;&dollar;TOGAF_THEME_ENABLED = %true()

' Archimate and TOGAF
&excl;define MBpuml https://markbodach.github.io/plantuml
&excl;includeurl MBpuml/all.puml


' Your custom components are now available globally!
'MyCustomDatabase(db1, "User Database")
@enduml
```

