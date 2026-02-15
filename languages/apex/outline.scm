; inspired by: https://github.com/zed-extensions/java/blob/main/languages/java/outline.scm
(class_declaration
    (modifiers
        (modifier
            [
                (private)
                (public)
                (protected)
                (virtual)
                (abstract)
                (global)
                (with_sharing)
                (without_sharing)
                (inherited_sharing)
            ]) @context)*
    "class" @context
    name: (_) @name) @item

(interface_declaration
    (modifiers
        (modifier
            [
                (private)
                (public)
                (protected)
                (virtual)
                (global)
            ]) @context)*
    "interface" @context
    name: (_) @name) @item

(method_declaration
    (modifiers
        (modifier
            [
                (private)
                (public)
                (protected)
                (global)
                (virtual)
                (override)
                (webservice)
                (testMethod)
                (static)
            ]) @context)*
    name: (_) @name
    parameters: (formal_parameters
      "(" @context
      ")" @context)) @item

(field_declaration
    (modifiers
        (modifier
            [
                (private)
                (public)
                (protected)
                (global)
                (static)
                (final)
                (transient)
            ]) @context)*
    declarator: (variable_declarator
        name: (_) @name)) @item

(enum_declaration
    name: (_) @name) @item

(trigger_declaration
    name: (_) @name) @item

(annotation
    name: (_) @name) @annotation
