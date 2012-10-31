
module ::Perspective::HTML::Form::Input

  include ::Perspective::HTML::View
  
  extend ::Module::Cluster
  
  cascade = cluster( :perspective ).before_include_or_extend.cascade
  cascade.extend( ::Perspective::HTML::Form::Input::ClassInstance )

  attr_text_or_number  :input, ::Perspective::HTML::Elements::Form::Input::TextInput do
    input.name.value = input.__route_string__
  end

  attr_alias           :name, input.name

  attr_alias           :value, input.value
  
  attr_text_or_number  :label, ::Perspective::HTML::Elements::Form::Input::InputLabel do
    label.for_input.value = input.name.value
  end

  attr_text_or_number  :error, ::Perspective::HTML::Elements::Form::Input::InputError do
    error.for_input.value = input.name.value
  end

  attr_order           :label, :error, :input

end
