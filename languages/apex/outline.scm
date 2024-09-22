; inspired by: https://github.com/zed-extensions/java/blob/main/languages/java/outline.scm
(class_declaration
    (modifiers
        [
            "private"
            "public"
            "protected"
            "virtual"
            "abstract"
            "with sharing"
            "without sharing"
            "inherited sharing"
        ]* @context)
    "class" @context
    name: (_) @name) @item

(interface_declaration
    (modifiers
        [
            "private"
            "public"
            "protected"
            "virtual"
            "global"
        ]* @context)
    "interface" @context
    name: (_) @name) @item

(method_declaration
    (modifiers
        [
            "private"
            "public"
            "protected"
            "global"
            "virtual"
            "override"
            "webservice"
            "testmethod"
            "@isTest"
            "@future"
            "@invocableMethod"
            "@AuraEnabled"
        ]* @context)
    name: (_) @name
    parameters: (formal_parameters
      "(" @context
      ")" @context)) @item

(property_declaration
    (modifiers
        [
            "private"
            "public"
            "protected"
            "global"
            "static"
            "final"
            "transient"
        ]* @context)
    name: (_) @name) @item

(field_declaration
    (modifiers
        [
            "private"
            "public"
            "protected"
            "global"
            "static"
            "final"
            "transient"
        ]* @context)
    declarator: (variable_declarator
        name: (_) @name)) @item

(annotation
    name: (_) @name) @annotation