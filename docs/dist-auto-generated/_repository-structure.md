## 📦 Bundled Repository Tree

This tree maps out exactly how the source code files were evaluated and sequenced into the final `all.puml` production asset.

```text
/c/dev/plantuml/src/all.puml (Root Master)
  └── index.puml
    └── libs/index.puml
      └── stdlib/framework/index.puml
        └── _assert.puml
        └── _debug.puml
        └── _breakpoint.puml
        └── _apply.puml
        └── _helpers.puml
        └── _corruption.puml
        └── _extensions.puml
      └── stdlib/vars/index.puml
        └── _root.puml
        └── _corruption_registry.puml
        └── _extension_registry.puml
        └── _colors.puml
      └── archimate/vars/index.puml
        └── _root.puml
        └── _corruption_repair.puml
        └── _sprites.puml
      └── stdlib/components/index.puml
        └── _strings.puml
        └── _variables.puml
        └── _text.puml
        └── _hex.puml
        └── _colors.puml
        └── _darken.puml
        └── _lighten.puml
        └── _resolver.puml
        └── _corruption_detection.puml
      └── archimate/components/index.puml
        └── _sprite_registry.puml
        └── _sprite.puml
        └── _rectangle.puml
        └── _shapes.puml
        └── _element.puml
      └── stdlib/theme/index.puml
        └── _colors.puml
        └── _fonts.puml
        └── _spacing.puml
        └── _borders.puml
        └── _corners.puml
        └── _widths.puml
        └── _heights.puml
        └── _element.puml
        └── _layout.puml
        └── _icons.puml
        └── _title.puml
        └── _component.puml
      └── archimate/theme/index.puml
        └── _fonts.puml
        └── _colors.puml
        └── _derived_variables.puml
        └── _corners.puml
        └── _widths.puml
      └── stdlib/skinparams/index.puml
      └── archimate/skinparams/index.puml
      └── stdlib/styles/index.puml
        └── _utilities.puml
        └── _card.puml
        └── _panel.puml
        └── _containers.puml
        └── _title.puml
        └── _element.puml
        └── _component.puml
      └── archimate/styles/index.puml
        └── _element.puml
      └── _load.puml
```
