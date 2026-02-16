;; Apex syntax highlighting
;; Based on tree-sitter-sfapex v2.4.1 highlights
;; Capture names follow Zed conventions
;;
;; IMPORTANT: Zed uses last-match-wins for overlapping captures.
;; More important captures (keywords, types) appear LATER in this file.

;; ---------------------------------------------------------------------------
;; Comments & Literals (lowest priority - overridden by everything)
;; ---------------------------------------------------------------------------

[
  (line_comment)
  (block_comment)
] @comment

[
  (string_literal)
] @string

[
  (int)
  (decimal_floating_point_literal)
] @number

;; ---------------------------------------------------------------------------
;; Punctuation
;; ---------------------------------------------------------------------------

[
  "["
  "]"
  "{"
  "}"
  "?"
  ";"
] @punctuation

(type_arguments "<" @punctuation)
(type_arguments ">" @punctuation)

;; ---------------------------------------------------------------------------
;; SOQL highlights (inline queries parsed by the Apex grammar)
;; ---------------------------------------------------------------------------

(field_identifier
  (identifier) @property)

(field_identifier
  (dotted_identifier
    (identifier) @property))

(type_of_clause
  (identifier) @property)

(when_expression
  (identifier) @type)

(when_expression
  (field_list
    (identifier) @property))

(when_expression
  (field_list
    (dotted_identifier
      (identifier) @property )))

(else_expression
  (field_list
    (identifier) @property ))

(else_expression
  (field_list
    (dotted_identifier
      (identifier) @property )))

(alias_expression
  (identifier) @label)

(storage_identifier) @type

(_ function_name:(identifier) @function)

(date_literal) @constant.builtin

; SOQL logical operators (these tokens only exist within SOQL query nodes)
[
  "AND"
  "OR"
  "NOT"
] @operator

; SOQL comparison operators (scoped to SOQL-specific node types)
(value_comparison_operator) @operator
(set_comparison_operator) @operator

(decimal) @number
(currency_literal) @number
(date) @constant
(date_time) @constant

[
  "TRUE"
  "FALSE"
  (null_literal)
] @constant.builtin

[
  "ABOVE"
  "ABOVE_OR_BELOW"
  "ALL"
  "AS"
  "ASC"
  "AT"
  "BELOW"
  "CUSTOM"
  "DATA_CATEGORY"
  "DESC"
  "ELSE"
  "END"
  "FIELDS"
  "FOR"
  "FROM"
  "GROUP_BY"
  "HAVING"
  "LIMIT"
  "NULLS_FIRST"
  "NULLS_LAST"
  "OFFSET"
  "ORDER_BY"
  "REFERENCE"
  "SELECT"
  "STANDARD"
  "THEN"
  "TRACKING"
  "TYPEOF"
  "UPDATE"
  "USING"
  "SCOPE"
  "LOOKUP"
  "BIND"
  "VIEW"
  "VIEWSTAT"
  "WITH"
  "WHERE"
  "WHEN"
] @keyword

; Using Scope
[
  "delegated"
  "everything"
  "mine"
  "mine_and_my_groups"
  "my_territory"
  "my_team_territory"
  "team"
] @constant

; With
[
  "maxDescriptorPerRecord"
  "RecordVisibilityContext"
  "Security_Enforced"
  "supportsDomains"
  "supportsDelegates"
  "System_Mode"
  "User_Mode"
  "UserId"
] @constant

;; ---------------------------------------------------------------------------
;; SOSL highlights (inline queries parsed by the Apex grammar)
;; ---------------------------------------------------------------------------

(find_clause
  (term) @string )

(sobject_return
  (identifier) @type )

(with_type (_ "=" @operator))

[
  "DIVISION"
  "EMAIL"
  "FIND"
  "ListView"
  "HIGHLIGHT"
  "METADATA"
  "NAME"
  "NETWORK"
  "PHONE"
  "PricebookId"
  "RETURNING"
  "SIDEBAR"
  "SNIPPET"
  "SPELL_CORRECTION"
  "target_length"
] @keyword

;; ---------------------------------------------------------------------------
;; Variables & Properties
;; ---------------------------------------------------------------------------

(this) @variable.builtin
(super) @function.builtin

(argument_list
  (identifier) @variable)

(explicit_constructor_invocation
  arguments: (argument_list
    (identifier) @variable ))

( expression_statement (_ (identifier)) @variable)

(return_statement
  (identifier) @variable)

(local_variable_declaration
  (variable_declarator
    name: (identifier) @variable ))

(for_statement
  condition: (binary_expression
    (identifier) @variable))

(for_statement
  update: (update_expression
    (identifier) @variable))

(bound_apex_expression
  (identifier) @variable)

(binary_expression
  (identifier) @variable)

(assignment_expression
  left: (identifier) @variable)

(switch_expression
  condition: (identifier) @variable)

(switch_rule
  (switch_label
    (identifier) @constant ))

(enhanced_for_statement
  value: (identifier) @variable)

(enhanced_for_statement
  name: (identifier) @variable)

(field_access
  field: (identifier) @property)

(field_declaration (variable_declarator
  (identifier) @property))

(field_declaration
  (modifiers (modifier [(final) (static)])(modifier [(final) (static)]))
  (variable_declarator
    name: (identifier) @constant))

;; Screaming snake case convention for constants
((identifier) @constant
  (#match? @constant "^_*[A-Z][A-Z\\d_]+$"))

;; ---------------------------------------------------------------------------
;; Annotations
;; ---------------------------------------------------------------------------

; Capture @ inside the annotation pattern (matches Zed Java extension approach)
(annotation
  "@" @punctuation.special
  name: (identifier) @attribute)

(annotation_key_value
  (identifier) @variable)

;; ---------------------------------------------------------------------------
;; Types
;; ---------------------------------------------------------------------------

;; General catch-all for type_identifier (later specific patterns also use @type
;; but since they all share the same capture name, the general one fills gaps
;; for types like AvochatoApiResponse that may not match a specific context)
(type_identifier) @type

(interface_declaration
  name: (identifier) @type)
(class_declaration
  name: (identifier) @type)
(class_declaration
  (superclass) @type)
(enum_declaration
  name: (identifier) @enum)
(enum_constant
  name: (identifier) @constant)

(interfaces
  (type_list
    (type_identifier) @type ))

(local_variable_declaration
  (type_identifier) @type )

((field_access
  object: (identifier) @type))

(generic_type
  (type_identifier) @type)
(type_arguments (type_identifier) @type)

((scoped_identifier
  scope: (identifier) @type)
 (#match? @type "^[A-Z]"))
((method_invocation
  object: (identifier) @type)
 (#match? @type "^[A-Z]"))

(field_declaration
  type: (type_identifier) @type)

(formal_parameter
  type: (type_identifier) @type
  (identifier) @variable)

(method_declaration
  (formal_parameters
    (formal_parameter
      name: (identifier) @variable.parameter)))

(enhanced_for_statement
  type: (type_identifier) @type
  name: (identifier) @variable )

(object_creation_expression
  type: (type_identifier) @type)

(array_creation_expression
  type: (type_identifier) @type)

(array_type
  element: (type_identifier) @type)

(instanceof_expression
  left: (identifier) @variable
  right: (type_identifier) @type )

(cast_expression
  type: (type_identifier) @type
  value: (identifier) @variable)

(when_sobject_type
  (type_identifier) @type
  (identifier) @variable )

(scoped_type_identifier
  (type_identifier) @type)

[
  (boolean_type)
  (void_type)
] @type.builtin

;; ---------------------------------------------------------------------------
;; Functions & Methods
;; ---------------------------------------------------------------------------

(method_declaration
  name: (identifier) @function.method)
(method_declaration
  type: (type_identifier) @type)

(method_invocation
  name: (identifier) @function.method)

(constructor_declaration
  name: (identifier) @constructor)

(dml_type) @function.builtin

"System.runAs" @function.builtin

;; ---------------------------------------------------------------------------
;; Triggers
;; ---------------------------------------------------------------------------

(trigger_declaration
  name: (identifier) @type
  object: (identifier) @type
  (trigger_event) @keyword
  ("," (trigger_event) @keyword)*)

;; ---------------------------------------------------------------------------
;; Operators
;; ---------------------------------------------------------------------------

(assignment_operator) @operator

(update_operator) @operator

(binary_expression
  operator: [
    ">"
    "<"
    ">="
    "<="
    "=="
    "==="
    "!="
    "!=="
    "&&"
    "||"
    "+"
    "-"
    "*"
    "/"
    "&"
    "|"
    "^"
    "%"
    "<<"
    ">>"
    ">>>"] @operator)

(unary_expression
  operator: [
    "+"
    "-"
    "!"
    "~"
  ]) @operator

("=>" @operator)

;; ---------------------------------------------------------------------------
;; Keywords (LAST - highest priority in Zed's last-match-wins system)
;; ---------------------------------------------------------------------------

[
  (abstract)
  (all_rows_clause)
  "break"
  "catch"
  "class"
  "continue"
  "do"
  "else"
  "enum"
  "extends"
  (final)
  "finally"
  "for"
  "get"
  (global)
  "if"
  "implements"
  "instanceof"
  "interface"
  "new"
  "on"
  (override)
  (private)
  (protected)
  (public)
  "return"
  "set"
  (static)
  "switch"
  (testMethod)
  (webservice)
  "throw"
  (transient)
  "try"
  "trigger"
  (virtual)
  "when"
  "while"
  (with_sharing)
  (without_sharing)
  (inherited_sharing)
] @keyword

;; Explicit modifier captures for declarations (belt-and-suspenders)
;; These ensure keyword highlighting works even when modifiers follow annotations,
;; by matching the modifier node directly within declaration contexts.
(method_declaration (modifiers (modifier) @keyword))
(field_declaration (modifiers (modifier) @keyword))
(constructor_declaration (modifiers (modifier) @keyword))
(class_declaration (modifiers (modifier) @keyword))
(interface_declaration (modifiers (modifier) @keyword))
(enum_declaration (modifiers (modifier) @keyword))
