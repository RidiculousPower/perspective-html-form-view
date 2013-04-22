# -*- encoding : utf-8 -*-

[

  'view/rack_application',
  
  'view/configuration',

  '../../binding_types/html_form_view',
  '../../binding_types/html_form_view_bindings',
  '../../binding_types/html_form_view_bindings/class_binding',
  '../../binding_types/html_form_view_bindings/instance_binding',
  
  'view/input',
  
  '../../binding_types/html_form_view_input',
  '../../binding_types/html_form_view_input_bindings',
  '../../binding_types/html_form_view_input_bindings/class_binding',
  '../../binding_types/html_form_view_input_bindings/instance_binding',
  '../../binding_types/html_form_view_input_bindings/button_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/checkbox_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/color_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/datalist_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/date_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/date_time_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/email_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/file_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/hidden_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/month_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/number_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/password_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/radio_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/range_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/search_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/select_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/telephone_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/text_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/textarea_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/time_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/url_input/class_binding',
  '../../binding_types/html_form_view_input_bindings/week_input/class_binding',

  'view/context',

  'view/singleton_instance',
  'view/object_instance',
  
  'view/exception/form_binding_expected'
    
].each { |this_file| require_relative( this_file << '.rb' ) }
