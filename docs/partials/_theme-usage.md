## Theme Usage

All diagrams should include the shared theme.

```plantuml
@startuml

!include ../themes/panelapp-theme.puml

@enduml
```

The theme provides:

- Color standards
- Font standards
- Border standards
- Layout standards
- Architecture stereotypes
- Reusable legend definitions

## Color Token Resolution

The style framework supports semantic color tokens, computed values, and literal colors.

### Supported Values

| Value | Description | Example |
|---------|-------------|---------|
| `AUTO` | Automatically derive an appropriate value from context. | `FONT_COLOR_TITLE = "AUTO"` |
| `CURRENT` | Use the current component's resolved surface/background color. | `LINE_COLOR_TITLE = "CURRENT"` |
| `*_TEXT` | Use the contrast text color for a semantic token. | `PRIMARY_DARK_TEXT` |
| Semantic Token | Resolve through the active theme. | `PRIMARY_DARK` |
| Literal Color | Use directly without transformation. | `#023451` |

### Resolution Order

| Priority | Rule |
|----------|------|
| 1 | `AUTO` |
| 2 | `CURRENT` |
| 3 | `*_TEXT` |
| 4 | Semantic token |
| 5 | Literal color |

### Example

#### Configuration

```plantuml
!$BACKGROUND_COLOR_TITLE = "PRIMARY_DARK"
!$FONT_COLOR_TITLE       = "AUTO"
!$LINE_COLOR_TITLE       = "CURRENT"