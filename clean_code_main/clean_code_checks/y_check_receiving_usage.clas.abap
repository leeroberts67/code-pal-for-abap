CLASS y_check_receiving_usage DEFINITION
  PUBLIC
  INHERITING FROM y_check_base
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .
  PROTECTED SECTION.
    METHODS inspect_tokens REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.



CLASS Y_CHECK_RECEIVING_USAGE IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).

    description = 'RECEIVING Statement Usage'(001).
    category    = 'Y_CHECK_CATEGORY'.
    position = '780'.
    version = '0000'.
    has_documentation = abap_true.

    settings-pseudo_comment = '"#EC RECEIVING_USAGE' ##NO_TEXT.
    settings-disable_threshold_selection = abap_true.
    settings-threshold = 0.
    settings-documentation = |{ c_docs_path-checks }receiving-usage.md|.

    y_message_registration=>add_message(
      EXPORTING
        check_name     = me->myname
        text           = '[Clean Code]: ABAP Keyword: "RECEIVING", should not be used!'(102)
        pseudo_comment = settings-pseudo_comment
      CHANGING
        messages       = me->scimessages ).
  ENDMETHOD.                    "CONSTRUCTOR


  METHOD inspect_tokens.
    CHECK get_token_abs( statement-from ) CP '*(*' AND
          get_token_abs( statement-from ) NE 'BADI'.

    DATA(has_receiving) = abap_false.
    DATA(has_classic_exception) = abap_false.

    DATA(token_index) = 0.

    LOOP AT ref_scan_manager->get_tokens( ) ASSIGNING FIELD-SYMBOL(<token>)
      FROM statement-from TO statement-to.
      IF has_receiving = abap_false.
        has_receiving = xsdbool( <token>-str EQ 'RECEIVING' AND
                                 get_token_abs( statement-from + token_index + 1 ) NE '=' ).
      ENDIF.
      IF has_classic_exception = abap_false.
        has_classic_exception = xsdbool( <token>-str EQ 'EXCEPTIONS' AND
                                         get_token_abs( statement-from + token_index + 1 ) NE '=' ).
      ENDIF.

      token_index = token_index + 1.
    ENDLOOP.

    DATA(check_configuration) = detect_check_configuration( statement ).

    IF check_configuration IS INITIAL.
      RETURN.
    ENDIF.

    IF has_receiving = abap_true AND has_classic_exception = abap_false.
      raise_error( statement_level     = statement-level
                   statement_index     = index
                   statement_from      = statement-from
                   error_priority      = check_configuration-prio ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
