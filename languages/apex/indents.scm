; inspired by: https://github.com/zed-extensions/java/blob/main/languages/java/indents.scm

; format-ignore
[
  ; ... refers to the portion that this indent query will have effects on
  (class_body)                        ; { ... } of `class X`
  (enum_body)                         ; { ... } of `enum X`
  (interface_body)                    ; { ... } of `interface X`
  (constructor_body)                  ; { `modifier` X() {...} } inside `class X`
  (trigger_body)                      ; { ... } of `trigger X`
  (block)                             ; { ... } that's not mentioned in this scope
  (switch_block)                      ; { ... } in `switch X`
  (list_initializer)                  ; new List<Integer>{1, 2}
  (set_initializer)                   ; new Set<String>{'a', 'b'}
  (map_initializer)                   ; new Map<String, Integer>{'key' => 1}
  (argument_list)                     ; foo(...)
  (formal_parameters)                 ; method foo(...)
  (annotation_argument_list)          ; @Annotation(...)
] @indent.begin

(expression_statement
  (method_invocation) @indent.begin)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @indent.branch

(annotation_argument_list
  ")" @indent.end) ; This should be a special cased as `()` here doesn't have ending `;`

"}" @indent.end

(line_comment) @indent.ignore

[
  (ERROR)
  (block_comment)
] @indent.auto