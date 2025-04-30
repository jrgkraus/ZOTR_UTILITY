# Motivation
For language dependent user interface texts, we used to use text elements in the last decade. However, there is a more modern option for storing texts: the online text repository, that came with BSP and WebDynpro technology, and is used also by exception classes. What if we want to use this also in our application classes? Here is a package, that offers two classes for an easy usage of OTR texts. They are intended to be used for inheritance.

# The SAP basics
Apart from the well-known text elements in programs, SAP offers a more modern way to use language-dependent texts: the online text repository (OTR).

Texts can be maintained by transaction SOTR_EDIT

![image](https://github.com/user-attachments/assets/f2a61978-bfd3-4f0d-82e4-bd6b51675350)


The alias can be used to fetch the text in ABAP using class CL_BSP_GET_TEXT_BY_ALIAS. In order to not interfere with other packages, use the package as a prefix (recommendation from SAP)
![image](https://github.com/user-attachments/assets/635208c3-acc5-436b-ab25-bc075906450d)

Make sure to use object type CPUB (Public header - ABAP Objects).

After saving, translation can be called directly:

![image](https://github.com/user-attachments/assets/325129dd-1424-41ef-865e-f73a341068d1)


Then, the text can be fetched in ABAP like this:

    data(text) = new CL_BSP_GET_TEXT_BY_ALIAS(
       )->get_text(
            language = sy-langu
            alias = 'ZOTR_UTILITY/EXAMPLE' ).

Of course that's not quite convenient. So I created a framework for this

# The framework
To use the framework, two classes have to be implemented.

Class to read the texts:

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

The only purpose is to setup the prefix for the texts of this package. It is designed to be used as a super class wherever texts are needed. I use this eclipse template to create it:

    class ${enclosing_object} definition
      public
      inheriting from zcl_dv24_text_access
      create public .
     
      public section.
        METHODS constructor.
      protected section.
      private section.
    endclass.
 
    class ${enclosing_object} implementation.
     
      method constructor.
     
        super->constructor( ).
     
        me->package = '${enclosing_package}'.
      endmethod.
    endclass.

With this, no further edits are needed .

ENUM class for the texts

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

Here, all the texts used in the package can be inserted. The template I use is like this:

    class ${enclosing_object} definition
      public
      inheriting from zcl_dv24_text_enum
      create public .
     
      public section.
        class-data ${first_element} type self read-only.
        class-methods class_constructor.
      protected section.
      private section.
    endclass.
 
    class ${enclosing_object} implementation.
      method class_constructor.
        define _element.
          &1 = new #( &2 ).
          insert value #( value = &2
                          instance = &1 ) into table elements.
        end-of-definition.
        _element:
          _null       ' ',
          ${first_element}    '${cursor}'.
      endmethod.
    endclass.

With this setup, the usage is very simple:

    report zp_dv24_text_demo.
     
    class text definition inheriting from zcl_dv24_demo_text_enum.
    endclass.
     
    class app definition inheriting from zcl_dv24_demo_texts.
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

If the text is not present in the logon language, the framework will provide the text in English, if available.
