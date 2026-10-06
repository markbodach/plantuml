# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* Compiled Bundle: **`all.puml`**
* Generated on: **2026-10-06 18:47:47 EDT**
* Build Commit Hash: **d4b5e476e4bb3923a99fbb46909d7d51c3bda0a9**
* Build Commit Comment: **more edge cases**

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
Load_Lib_Styles_All()

@enduml
```

