"#autoformat
CLASS zcl_csv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES1:
      "! <p>Table of string</p>
      ty_t_string TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    "! <p>Create a table with separator</p>
    "! @parameter it_table | <p>Table to transform</p>
    "! @parameter iv_separator | <p>Separator you want to use<br/><strong>Default:</strong> ;</p>
    "! @parameter iv_headline | <p>Optional: Headline of CSV file</p>
    "! @parameter rt_table_with_separator | <p>Table of string return</p>
    CLASS-METHODS _create_table_with_separator
      IMPORTING
        it_table                       TYPE STANDARD TABLE
        iv_separator                   TYPE c DEFAULT ';'
        iv_headline                    TYPE string OPTIONAL
      RETURNING
        VALUE(rt_table_with_separator) TYPE ty_t_string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csv IMPLEMENTATION.

  METHOD _create_table_with_separator.

    DATA: ls_xout TYPE string.
    DATA: lv_string TYPE string.

    IF iv_headline <> ''.
      APPEND iv_headline TO rt_table_with_separator.
    ENDIF.

    LOOP AT it_table ASSIGNING FIELD-SYMBOL(<ls_table>).

      CLEAR ls_xout.
      DO.
        ASSIGN COMPONENT sy-index OF STRUCTURE <ls_table> TO FIELD-SYMBOL(<fs_value>).
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.
        IF sy-index = 1.
          lv_string = <fs_value>.
          ls_xout = <fs_value>.
        ELSE.
          lv_string = <fs_value>.
          CONCATENATE ls_xout lv_string INTO ls_xout SEPARATED BY iv_separator.
        ENDIF.
      ENDDO.

      APPEND ls_xout TO rt_table_with_separator.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
