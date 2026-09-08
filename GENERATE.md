
## Generating Diagrams

Generate PNG output:

```bash
plantuml diagram.puml
```

Generate SVG output:

```bash
plantuml -tsvg diagram.puml
```

Generate all diagrams:

```bash
find diagrams -name "*.puml" -exec plantuml {} \;
```
