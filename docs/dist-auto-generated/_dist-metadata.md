# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* Compiled Bundle: **`all.puml`**
* Generated on: **2026-09-25 16:03:53 EDT**
* Build Commit Hash: **6eabc8cba274cd81a73b0629a0c69946c96357b0**
* Build Commit Comment: **component styling**

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

