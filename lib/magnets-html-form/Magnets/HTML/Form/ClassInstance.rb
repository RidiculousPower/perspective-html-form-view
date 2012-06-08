
module ::Magnets::HTML::Form::ClassInstance
  
  include ::Magnets::HTML::Form::Configuration
  
  ::Magnets::Bindings::Attributes.define_container_type( :HTML_form, false, :HTML_view_model ) do

    # We only want our inputs to have form bindings - otherwise they behave just like normal views.

    base = ::Magnets::HTML::Form::Input
    
    define_binding_type( :button_input ).__view_class__ = base::ButtonInput
    define_binding_type( :checkbox_input ).__view_class__ = base::CheckboxInput
    define_binding_type( :color_input ).__view_class__ = base::ColorInput
    define_binding_type( :datalist_input ).__view_class__ = base::DataListInput
    define_binding_type( :date_input ).__view_class__ = base::DateInput
    define_binding_type( :datetime_input ).__view_class__ = base::DateTimeInput
    define_binding_type( :email_input ).__view_class__ = base::EmailInput
    define_binding_type( :file_input ).__view_class__ = base::FileUploadInput
    define_binding_type( :hidden_input ).__view_class__ = base::HiddenInput
    define_binding_type( :month_input ).__view_class__ = base::MonthInput
    define_binding_type( :number_input ).__view_class__ = base::NumberInput
    define_binding_type( :password_input ).__view_class__ = base::PasswordInput
    define_binding_type( :radio_input ).__view_class__ = base::RadioInput
    define_binding_type( :range_input ).__view_class__ = base::RangeInput
    define_binding_type( :search_input ).__view_class__ = base::SearchInput
    define_binding_type( :select_input ).__view_class__ = base::SelectInput
    define_binding_type( :telephone_input ).__view_class__ = base::TelephoneInput
    define_binding_type( :textarea_input ).__view_class__ = base::TextInput
    define_binding_type( :text_input ).__view_class__ = base::TextInput::TextAreaInput 
    define_binding_type( :time_input ).__view_class__ = base::TimeInput
    define_binding_type( :url_input ).__view_class__ = base::URLInput
    define_binding_type( :week_input ).__view_class__ = base::WeekInput
    
  end
  
  include ::Magnets::Bindings::AttributeContainer::HTMLForm
  
end
