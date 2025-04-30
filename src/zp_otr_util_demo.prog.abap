*&---------------------------------------------------------------------*
*& Report zp_dv24_text_demo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zp_otr_util_demo.

class text definition inheriting from zcl_otr_util_demo_text_enum.
endclass.

class app definition inheriting from zcl_otr_util_demo_texts.
  public section.
    methods main.
endclass.

CLASS app IMPLEMENTATION.
  method main.
    cl_demo_output=>display( get_text( text=>the_text ) ).
  endmethod.
ENDCLASS.

start-of-selection.
  new app( )->main( ).
