# -*- encoding : utf-8 -*-

# Form-enabled views need bindings that know how to account for indexing forms present
::Perspective::BindingTypes.define_container_type( :HTML_form, :HTML_view_model, false ) do

  define_binding_type( :form, :view )

end
