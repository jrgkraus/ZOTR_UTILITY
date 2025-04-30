class ZCL_OTR_UTIL_DEMO_TEXTS definition
  public
  inheriting from zcl_otr_util_texts
  create public .

  public section.
    METHODS constructor.
  protected section.
  private section.
endclass.



class ZCL_OTR_UTIL_DEMO_TEXTS implementation.

  method constructor.

    super->constructor( ).

    me->package = 'ZOTR_UTILITY'.
  endmethod.
endclass.
