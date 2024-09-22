(
    (class_declaration
        (class_body
            (method_declaration
                (modifier) @_modifier
                (#match? @_modifier "^(testMethod|@isTest)$")
                (identifier) @run @test_method
            )
        )
    )
    (#set! tag apex-test)
)