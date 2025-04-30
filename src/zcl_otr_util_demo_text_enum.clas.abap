class ZCL_OTR_UTIL_DEMO_TEXT_ENUM definition
  public
  inheriting from zcl_otr_util_enum_texts
  create public .

  public section.
    class-data the_text type self read-only.
    class-methods class_constructor.
  protected section.
  private section.
endclass.



class ZCL_OTR_UTIL_DEMO_TEXT_ENUM implementation.
  method class_constructor.
    define _element.
      &1 = new #( &2 ).
      insert value #( value = &2
                      instance = &1 ) into table elements.
    end-of-definition.
    _element:
      _null       ' ',
      the_text    'EXAMPLE'.
  endmethod.
endclass.
