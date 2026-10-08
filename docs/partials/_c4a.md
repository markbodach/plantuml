
## Chapter 4: Distribution and Repository Structure

### Core Distribution

The core bundle contains StdLib and TOGAF support:

```text
all.puml
```

### Theme Distribution

Every immediate child folder under `src/themes` is compiled independently:

```text
src/themes/<folder-name>/index.puml
    ↓
theme-<folder-name>.puml
```

Examples:

```text
theme-corporate.puml
theme-product.puml
theme-customer.puml
```

Themes are not embedded in `all.puml`. A diagram includes only the theme bundles it needs.

### Source Layout
