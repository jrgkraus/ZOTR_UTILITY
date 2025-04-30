class ZCL_OTR_UTIL_ENUM_TEXTS definition
  public
  create public .

  public section.
    types self type ref to ZCL_OTR_UTIL_ENUM_TEXTS.

    class-data _null type self read-only.
    data value type string read-only.


    methods get_by_value
      importing
        i_value         like value
      returning
        value(result) type self.

    methods constructor
      importing
        i_value like value optional.

  protected section.
    class-data:
      begin of element,
        value    like value ,
        instance type self,
      end of element,
      elements like standard table of element with empty key.
  private section.
endclass.



class ZCL_OTR_UTIL_ENUM_TEXTS implementation.

  method constructor.
    me->value = i_value.
  endmethod.


  method get_by_value.
    try.
        result = elements[ value = i_value ]-instance.
      catch cx_sy_itab_line_not_found.
        result = _null.
    endtry.
  endmethod.
endclass.
