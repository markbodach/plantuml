## Diagram Standards

### Naming

Use business-oriented names.

Preferred:

```text
PanelApp REST API
Background Worker Service
Identity Provider
```

Avoid:

```text
rest-api-v2
worker-01
authsvc
```

### Aliases

All PlantUML elements must use aliases.

Example:

```plantuml
component "PanelApp REST API" as RESTAPI
```

### Colors

| Architecture Element | Color |
|----------|----------|
| Application Pattern | #E2EEF9 |
| Business Pattern | #E2D7F3 |
| Infrastructure Pattern | #E8F6F3 |
| Technology Pattern | #EAF2F8 |
| Solution Building Block | #AED6F1 |
| Logical Component | #D6EAF8 |
| External System | #E8DAEF |
| Deployment Component | #F5B041 |
| Technology Product | #D5F5E3 |

Colors are managed centrally by the theme and should not be hardcoded within diagrams.

### Layout

Preferred settings:

```plantuml
left to right direction

skinparam linetype ortho
```

Use:

```plantuml
together {
}
```

and hidden relationships when required to improve layout readability.

## Traceability

Architecture traceability should generally follow:

```text
Pattern
    ↓
Solution Building Block
    ↓
Logical Component
    ↓
Deployment Component
    ↓
Technology Product
```

This enables reviewers to understand:

- Why a capability exists.
- Which architecture pattern it implements.
- Which logical components realize it.
- Which workloads deploy it.
- Which technologies support it.
