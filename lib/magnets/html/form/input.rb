
module ::Magnets::HTML::Form::Input

  include ::Magnets::HTML::View
  
  extend ::Module::Cluster
  
  cascade = cluster( :magnets ).before_include_or_extend.cascade
  cascade.extend( ::Magnets::HTML::Form::Input::ClassInstance )

  attr_text_or_number  :input, ::Magnets::HTML::Elements::Form::Input::TextInput

  attr_alias           :name, input.name

  attr_alias           :value, input.value
  
  attr_text_or_number  :label, ::Magnets::HTML::Elements::Form::Input::InputLabel do
    label_view.for_input = input_view
  end

  attr_text_or_number  :error, ::Magnets::HTML::Elements::Form::Input::InputError do
    error_view.for_input = input_view
  end
  
  attr_order           :label, :error, :input

end
