class zcl_otr_util_texts definition
  public
  abstract
  create public .

  public section.
    methods constructor.

    methods get_text
      importing
        alias         type ref to zcl_otr_util_enum_texts
      returning
        value(result) type string.
  protected section.
    data package type devclass.
  private section.
    constants english type spras value 'E'.
    data alias type ref to zcl_otr_util_enum_texts.
    data text_getter type ref to cl_bsp_get_text_by_alias.

    methods get_text_low
      importing
        language      type spras
      returning
        value(result) type string.
endclass.



class zcl_otr_util_texts implementation.
  method constructor.
    text_getter = new #( ).
  endmethod.

  method get_text.
    me->alias = alias.
    result =
      cond #(
        let local = get_text_low( sy-langu ) in
        when local is initial then
          get_text_low( english )
          else local ).
  endmethod.

  method get_text_low.
    result =
      text_getter->get_text(
            language   = language
            alias      = |{ package }/{ alias->value }| ).
  endmethod.

endclass.
