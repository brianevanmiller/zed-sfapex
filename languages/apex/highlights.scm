;; Apex syntax highlighting
;; Based on tree-sitter-sfapex v2.4.1 highlights
;; Capture names follow Zed conventions

[
  "["
  "]"
  "{"
  "}"
  "?"
  ";"
] @punctuation

;; Methods

(method_declaration
  name: (identifier) @function.method)
(method_declaration
  type: (type_identifier) @type)

(method_invocation
  name: (identifier) @function.method)
(argument_list
  (identifier) @variable)
(super) @function.builtin

(explicit_constructor_invocation
  arguments: (argument_list
    (identifier) @variable ))

;; Annotations

(annotation
  name: (identifier) @attribute)

"@" @operator

(annotation_key_value
  (identifier) @variable)


;; Types

;; because identifying it when declared doesn't carry to use
;; leans on the convention that "screaming snake case" is a const
((identifier) @constant
  (#match? @constant "^_*[A-Z][A-Z\\d_]+$"))

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

( expression_statement (_ (identifier)) @variable)

(type_arguments "<" @punctuation)
(type_arguments ">" @punctuation)

; (identifier) @variable

((field_access
  object: (identifier) @type)) ;; don't know what type of thing it is

(generic_type
  (type_identifier) @type)
(type_arguments (type_identifier) @type)

(field_access
  field: (identifier) @property)

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

(enhanced_for_statement
  value: (identifier) @variable)

(enhanced_for_statement
  name: (identifier) @variable)

(object_creation_expression
  type: (type_identifier) @type)

(array_creation_expression
  type: (type_identifier) @type)

(array_type
  element: (type_identifier) @type)

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

(constructor_declaration
  name: (identifier) @constructor)

(dml_type) @function.builtin

(bound_apex_expression
  (identifier) @variable)

(assignment_operator) @operator

(update_operator) @operator

(instanceof_expression
  left: (identifier) @variable
  right: (type_identifier) @type )

(cast_expression
  type: (type_identifier) @type
  value: (identifier) @variable)

(switch_expression
  condition: (identifier) @variable)

(switch_rule
  (switch_label
    (identifier) @constant ))

(when_sobject_type
  (type_identifier) @type
  (identifier) @variable )

(trigger_declaration
  name: (identifier) @type
  object: (identifier) @type
  (trigger_event) @keyword
  ("," (trigger_event) @keyword)*)

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

(binary_expression
  (identifier) @variable)

(unary_expression
  operator: [
    "+"
    "-"
    "!"
    "~"
  ]) @operator

("=>" @operator)

[
  (boolean_type)
  (void_type)
] @type.builtin

; Variables

(field_declaration (variable_declarator
  (identifier) @property))

(field_declaration
  (modifiers (modifier [(final) (static)])(modifier [(final) (static)]))
  (variable_declarator
    name: (identifier) @constant))

(this) @variable.builtin

; Literals

[
  (int)
  (decimal_floating_point_literal)
] @number

[
  (string_literal)
] @string

[
  (line_comment)
  (block_comment)
] @comment

;; Keywords

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

(assignment_expression
  left: (identifier) @variable)

; (type_identifier) @type ;; not respecting precedence...
;; I don't love this but couldn't break them up right now
;; can't figure out how to let that be special without conflicting
;; in the grammar
"System.runAs" @function.builtin

(scoped_type_identifier
  (type_identifier) @type)

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
