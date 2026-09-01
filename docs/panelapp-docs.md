
## Architecture Layers

### Design Patterns

Design Patterns represent reusable architecture guidance.

Examples:

- Identity Pattern
- Panel Aggregate Pattern
- Snapshot Versioning Pattern
- Audit & Traceability Pattern

Patterns are modeled using:

```plantuml
<<pattern-application>>
<<pattern-business>>
<<pattern-infrastructure>>
<<pattern-technology>>
```

Patterns are architecture assets and are not deployable solution components.

### Solution Building Blocks (SBB)

Solution Building Blocks represent reusable solution capabilities used to realize architecture patterns.

Examples:

- Identity Federation Service
- JWT Validation Service
- Authorization Engine
- Audit Logging Service

Modeled using:

```plantuml
<<sbb>>
```

### Logical Components

Logical Components represent the logical application architecture.

Examples:

- PanelApp REST API
- PanelApp GraphQL Services
- Background Worker Service
- Job Scheduling Service

Modeled using:

```plantuml
<<logical>>
```

### External Systems

External Systems represent dependencies outside the solution boundary.

Examples:

- Identity Provider
- Genomic Reference Sources

Modeled using:

```plantuml
<<external>>
```

### Deployment Components

Deployment Components represent runtime workloads and deployment units.

Examples:

- REST API Pod
- GraphQL Services Pod
- Background Worker Pod

Modeled using:

```plantuml
<<pod>>
```

### Technology Products

Technology Products represent implementation technologies and platforms.

Examples:

- AWS Cognito
- AWS OpenShift
- AWS Aurora PostgreSQL
- AWS CloudWatch

Modeled using:

```plantuml
<<technology>>
```

## Reusable Pattern Library

The repository provides reusable pattern macros.

Example:

```plantuml
!include ../libraries/panelapp-patterns.puml

PatternApplication(DP01, "Identity Pattern")
PatternApplication(DP02, "Panel Aggregate Pattern")
```

Result:

```text
Application Pattern
    ↓
Solution Building Block
    ↓
Logical Component
    ↓
Deployment Component
    ↓
Technology Product
```

This approach promotes consistency across architecture views.