
# Forms need to use form bindings
::Perspective::BindingTypes.define_container_type( :HTML_form_input, :HTML_view_model, false ) do

  # We only want our inputs to have form bindings - otherwise they behave just like normal views.

  base = ::Perspective::HTML::Form::View::Input
  
  define_binding_type( :button_input ).«view_class» = base::ButtonInput
  define_binding_type( :checkbox_input ).«view_class» = base::CheckboxInput
  define_binding_type( :color_input ).«view_class» = base::ColorInput
  define_binding_type( :datalist_input ).«view_class» = base::DataListInput
  define_binding_type( :date_input ).«view_class» = base::DateInput
  define_binding_type( :datetime_input ).«view_class» = base::DateTimeInput
  define_binding_type( :email_input ).«view_class» = base::EmailInput
  define_binding_type( :file_input ).«view_class» = base::FileUploadInput
  define_binding_type( :hidden_input ).«view_class» = base::HiddenInput
  define_binding_type( :month_input ).«view_class» = base::MonthInput
  define_binding_type( :number_input ).«view_class» = base::NumberInput
  define_binding_type( :password_input ).«view_class» = base::PasswordInput
  define_binding_type( :radio_input ).«view_class» = base::RadioInput
  define_binding_type( :range_input ).«view_class» = base::RangeInput
  define_binding_type( :search_input ).«view_class» = base::SearchInput
  define_binding_type( :select_input ).«view_class» = base::SelectInput
  define_binding_type( :telephone_input ).«view_class» = base::TelephoneInput
  define_binding_type( :text_input ).«view_class» = base::TextInput 
  define_binding_type( :textarea_input ).«view_class» = base::TextInput::TextAreaInput
  define_binding_type( :time_input ).«view_class» = base::TimeInput
  define_binding_type( :url_input ).«view_class» = base::URLInput
  define_binding_type( :week_input ).«view_class» = base::WeekInput

  define_binding_type( :subform, :view )
  
end
