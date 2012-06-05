
module ::Magnets::HTML::Form::Input

  include ::Magnets::HTML::View
  
  include_or_extend_cascades_prepend_extends ::Magnets::HTML::Form::Input::ClassInstance

  attr_view            :input, ::Magnets::HTML::Elements::Form::Input::Text

  attr_alias           :name, input.name

  attr_alias           :value, input.value
  
  attr_text_or_number  :label, ::Magnets::HTML::Elements::Form::Input::Label do

    label_view.for_input = input

  end

  attr_text_or_number  :error, ::Magnets::HTML::Elements::Form::Input::Error do

    error_view.for_input = input

  end
  
  attr_order           :label, :error, :input

end