# -*- encoding : utf-8 -*-

basepath = 'form'

files = [

  'rack_application',
  
  'input',
  'input/button_input',
  'input/checkbox_input',
  'input/color_input',
  'input/data_list_input',
  'input/date_input',
  'input/date_time_input',
  'input/email_input',
  'input/file_upload_input',
  'input/hidden_input',
  'input/month_input',
  'input/number_input',
  'input/password_input',
  'input/radio_input',
  'input/range_input',
  'input/search_input',
  'input/select_input',
  'input/telephone_input',
  'input/text_input',
  'input/text_input/text_area_input',
  'input/time_input',
  'input/url_input',
  'input/week_input',
  
  'configuration',

  'context',

  'input_binding/class_binding',
  'input_binding/class_binding/nested_class_binding',
  'input_binding/instance_binding',

  'form_binding/class_binding',
  'form_binding/class_binding/nested_class_binding',
  'form_binding/instance_binding',
  
  'class_instance',
  'object_instance',
  
  'exception/form_binding_expected'
    
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end
