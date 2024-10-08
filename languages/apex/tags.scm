(class_declaration
  name: (identifier) @name) @definition.class

(interface_declaration
  name: (identifier) @name) @definition.interface

(enum_declaration
  name: (identifier) @name) @definition.enum

(method_invocation
  name: (identifier) @name) @reference.call

(method_declaration
  name: (identifier) @name) @definition.method

(implements_list
  (type_identifier) @name) @reference.implementation

(variable_declaration
  type: (type_identifier) @name) @reference.class

(object_creation_expression
  type: (type_identifier) @name) @reference.class

(trigger_declaration
  name: (identifier) @name) @definition.trigger

(property_declaration
  name: (identifier) @name) @definition.property
