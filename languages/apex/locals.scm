; locals.scm

(method_declaration) @local.scope
(for_statement) @local.scope
(while_statement) @local.scope
(do_statement) @local.scope

(method_declaration
  (formal_parameters (formal_parameter (identifier) @local.definition)))

(variable_declaration . (identifier) @local.definition)

(enum_declaration
  name: (identifier) @local.definition)
(enum_constant
        name: (identifier) @local.definition)

(class_declaration
  name: (identifier) @local.definition)

(interface_declaration
  name: (identifier) @local.definition)

(identifier) @local.reference

(catch_clause
  (catch_formal_parameter . (identifier) @local.definition))

(for_statement
  (for_init
    (variable_declaration . (identifier) @local.definition)))
