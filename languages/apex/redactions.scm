; Redactions for Salesforce Apex

; Redact number literals
(integer) @redact
(decimal) @redact

; Redact string literals
(string) @redact

; Redact sensitive variables (e.g., passwords, tokens)
(variable_declarator
  name: (identifier) @_name
  (#match? @_name "(password|token|secret|key)")
  value: (_) @redact)

; Redact sensitive method calls (e.g., authentication methods)
(method_invocation
  name: (identifier) @_method
  (#match? @_method "(authenticate|login|getToken)")
  arguments: (arguments (_) @redact))

; Redact sensitive class members
(class_body_declaration
  (field_declaration
    type: (_)
    declarator: (variable_declarator
      name: (identifier) @_field
      (#match? @_field "(apiKey|clientSecret|accessToken)")
      value: (_) @redact)))

; Redact sensitive annotations
(annotation
  name: (identifier) @_annotation
  (#match? @_annotation "Sensitive")
  arguments: (annotation_argument_list (_) @redact))