# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* **Compiled Bundle:** `all.puml`
* **Generated on:** 2026-09-11 11:24:51 EDT
* **Build Commit Hash: b9c7dfc546ccf26918dc882d9fb8114e60522a27
* **Build Commit Comment: title v0.2

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

```plantuml
@startuml

' STEP 1 :: Enable the themes to be used
!$OH_THEME_ENABLED = %true()
!$TOGAF_THEME_ENABLED = %true()

' STEP 2 :: Load the Archimate and TOGAF library
!define MBpuml https://markbodach.github.io/plantuml/
!includeurl MBpuml/all.puml


' STEP 3 :: Apply the global styling - only the enabled themes will have styles applied
LoadThemeStyles_All()



@enduml
```

