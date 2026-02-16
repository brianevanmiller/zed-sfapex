; inspired by: https://github.com/zed-extensions/java/blob/main/languages/java/outline.scm
(class_declaration
    (modifiers)? @context
    "class" @context
    name: (_) @name) @item

(interface_declaration
    (modifiers)? @context
    "interface" @context
    name: (_) @name) @item

(method_declaration
    (modifiers)? @context
    name: (_) @name
    parameters: (formal_parameters
      "(" @context
      ")" @context)) @item

(field_declaration
    (modifiers)? @context
    declarator: (variable_declarator
        name: (_) @name)) @item

(enum_declaration
    name: (_) @name) @item

(trigger_declaration
    name: (_) @name) @item

(annotation
    name: (_) @name) @annotation
