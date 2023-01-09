; inherits: c

((identifier) @field
 (#match? @field "(^_|^m_|_$)"))

(parameter_declaration
  declarator: (reference_declarator) @parameter)

; function(Foo ...foo)
(variadic_parameter_declaration
  declarator: (variadic_declarator
                (_) @parameter))
; int foo = 0
(optional_parameter_declaration
    declarator: (_) @parameter)

;(field_expression) @parameter ;; How to highlight this?
(template_function
  name: (identifier) @function)

(template_method
  name: (field_identifier) @method)

(((field_expression
     (field_identifier) @method)) @_parent
 (#has-parent? @_parent template_method function_declarator call_expression))

(field_declaration
  (field_identifier) @field)

(field_initializer
 (field_identifier) @property)

(function_declarator
  declarator: (field_identifier) @method)

(concept_definition
  name: (identifier) @type.definition)

(alias_declaration
  name: (type_identifier) @type.definition)

(auto) @type.builtin

(namespace_identifier) @namespace
((namespace_identifier) @type
                        (#lua-match? @type "^[A-Z]"))
((namespace_identifier) @constant
                        (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))
(case_statement
  value: (qualified_identifier (identifier) @constant))
(namespace_definition
  name: (identifier) @namespace)

(using_declaration . "using" . "namespace" . [(qualified_identifier) (identifier)] @namespace)

(destructor_name
  (identifier) @method)

(function_declarator
      declarator: (qualified_identifier
        name: (identifier) @function))
(function_declarator
      declarator: (qualified_identifier
        name: (qualified_identifier
          name: (identifier) @function)))
((function_declarator
      declarator: (qualified_identifier
        name: (identifier) @constructor))
 (#lua-match? @constructor "^[A-Z]"))

(operator_name) @function
"operator" @function
"static_assert" @function.builtin

(call_expression
  function: (qualified_identifier
              name: (identifier) @function.call))
(call_expression
  function: (qualified_identifier
              name: (qualified_identifier
                      name: (identifier) @function.call)))
(call_expression
  function:
      (qualified_identifier
        name: (qualified_identifier
              name: (qualified_identifier
                      name: (identifier) @function.call))))

(call_expression
  function: (field_expression
              field: (field_identifier) @function.call))

((call_expression
  function: (identifier) @constructor)
(#lua-match? @constructor "^[A-Z]"))
((call_expression
  function: (qualified_identifier
              name: (identifier) @constructor))
(#lua-match? @constructor "^[A-Z]"))

((call_expression
  function: (field_expression
              field: (field_identifier) @constructor))
(#lua-match? @constructor "^[A-Z]"))

;; constructing a type in an initializer list: Constructor ():  **SuperType (1)**
((field_initializer
  (field_identifier) @constructor
  (argument_list))
 (#lua-match? @constructor "^[A-Z]"))


; Constants

(this) @variable.builtin
(nullptr) @constant

(true) @boolean
(false) @boolean

; Literals

(raw_string_literal)  @string

; Keywords

[
 "try"
 "catch"
 "noexcept"
 "throw"
] @exception


[
 "class"
 "decltype"
 "explicit"
 "friend"
 "namespace"
 "override"
 "template"
 "typename"
 "using"
 "co_await"
 "concept"
 "requires"
] @keyword

[
 "public"
 "private"
 "protected"
 "virtual"
 "final"
] @type.qualifier

[
 "co_yield"
 "co_return"
] @keyword.return

[
 "new"
 "delete"

 "xor"
 "bitand"
 "bitor"
 "compl"
 "not"
 "xor_eq"
 "and_eq"
 "or_eq"
 "not_eq"
 "and"
 "or"
] @keyword.operator

"<=>" @operator

"::" @punctuation.delimiter

(template_argument_list
  ["<" ">"] @punctuation.bracket)

(literal_suffix) @operator
; Constants

(this) @variable.builtin
(nullptr) @constant




[
 "catch"
 "class"
 "co_await"
 "co_return"
 "co_yield"
 "constexpr"
 "constinit"
 "consteval"
 "delete"
 "explicit"
 "final"
 "friend"
 "mutable"
 "namespace"
 "noexcept"
 "new"
 "override"
 "private"
 "protected"
 "public"
 "template"
 "throw"
 "try"
 "typename"
 "using"
 "virtual"
 "concept"
 "requires"
] @keyword

; Strings

(raw_string_literal) @string

(virtual_specifier) @virtual.specifier

; Functions

; These casts are parsed as function calls, but are not.
((identifier) @keyword (#eq? @keyword "static_cast"))
((identifier) @keyword (#eq? @keyword "dynamic_cast"))
((identifier) @keyword (#eq? @keyword "reinterpret_cast"))
((identifier) @keyword (#eq? @keyword "const_cast"))

(call_expression
  function: (qualified_identifier
    name: (identifier) @function))

(template_function
  name: (identifier) @function)

(template_method
  name: (field_identifier) @function)

(function_declarator
  declarator: (qualified_identifier
    name: (identifier) @function))

(function_declarator
  declarator: (qualified_identifier
    name: (qualified_identifier
      name: (identifier) @function)))

(function_declarator
  declarator: (field_identifier) @function)

; Types

(using_declaration ("using" "namespace" (identifier) @namespace))
(using_declaration ("using" "namespace" (qualified_identifier name: (identifier) @namespace)))
(namespace_definition name: (identifier) @namespace)
(namespace_identifier) @namespace

(qualified_identifier name: (identifier) @type.enum.variant)

(auto) @keyword
"decltype" @keyword

(ref_qualifier ["&" "&&"] @type.builtin)
(reference_declarator ["&" "&&"] @type.builtin)
(abstract_reference_declarator ["&" "&&"] @type.builtin)

; Constants

(this) @variable.builtin
(nullptr) @constant.builtin

; Keywords

(template_argument_list (["<" ">"] @punctuation.bracket))
(template_parameter_list (["<" ">"] @punctuation.bracket))
(default_method_clause "default" @keyword)

"static_assert" @function.special

[
  "<=>"
  "[]"
  "()"
] @operator

[
  "co_await"
  "co_return"
  "co_yield"
  "concept"
  "delete"
  "new"
  "operator"
  "requires"
  "using"
] @keyword

[
  "catch"
  "noexcept"
  "throw"
  "try"
] @keyword.control.exception


[
  "and"
  "and_eq"
  "bitor"
  "bitand"
  "not"
  "not_eq"
  "or"
  "or_eq"
  "xor"
  "xor_eq"
] @keyword.operator

[
  "class"  
  "namespace"
  "typename"
  "template"
] @keyword.storage.type

[
  "constexpr"
  "constinit"
  "consteval"
  "mutable"
] @keyword.storage.modifier

; Modifiers that aren't plausibly type/storage related.
[
  "explicit"
  "friend"
  "virtual"
  (virtual_specifier) ; override/final
  "private"
  "protected"
  "public"
  "inline" ; C++ meaning differs from C!
] @keyword

; Strings

(raw_string_literal) @string

(placeholder_type_specifier) @keyword
(type_descriptor) @type.descriptor
; inherits: c

([
 "catch"
 "class"
 "co_await"
 "co_return"
 "co_yield"
 "constexpr"
 "constinit"
 "consteval"
 "delete"
 "explicit"
 "final"
 "friend"
 "mutable"
 "namespace"
 "noexcept"
 "new"
 "override"
 "private"
 "protected"
 "public"
 "template"
 "throw"
 "try"
 "typename"
 "using"
 "virtual"
 "concept"
 "requires"
] @keyword(#set! "priority" 105))

(trailing_return_type 
   (type_descriptor)@keyword) 

(((type_descriptor) @keyword.override
  (#lua-match? @keyword.override "override"))
(#set! "priority" 105))
