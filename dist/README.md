# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* **Compiled Bundle:** `all.puml`
* **Generated on:** 2026-09-02 07:58:58 EDT

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

```plantuml
@startuml
&excl;include https://github.com/markbodach/plantuml

' Your custom components are now available globally!
MyCustomDatabase(db1, "User Database")
@enduml
```

## 📦 Bundled Architecture Tree
This tree maps out exactly how your source code files were evaluated and sequenced into this final `all.puml` production asset:

```text
src/all.puml (Root Master)
  └── index.puml
    └── themes/index.puml
      └── common/index.puml
        └── _colors.puml
        └── _fonts.puml
        └── _skinparam.puml
      └── togaf/index.puml
        └── _colors.puml
        └── _fonts.puml
      └── ontario-health/index.puml
        └── _colors.puml
        └── _fonts.puml
    └── libraries/index.puml
      └── stdlib/index.puml
      └── togaf/index.puml
        └── _business.puml
        └── _logical.puml
        └── _deployment.puml
        └── _technology.puml
      └── ontario-health/index.puml
        └── _patterns.puml
        └── _sbbs.puml
```
