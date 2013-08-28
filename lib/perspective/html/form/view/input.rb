# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::Input

  include ::Perspective::HTML::View
  
  extend ::Module::Cluster
  cluster = cluster( :perspective )
  cluster.before_include_or_extend.cascade.extend( ::Perspective::HTML::Form::View::Input::SingletonInstance )

  attr_text_or_number  :input, ::Perspective::HTML::Elements::Form::Input::TextInput do
    input.name = input.«route_string»
  end

  attr_alias           :name, input.name
  attr_alias           :value, input.value
  
  attr_text_or_number  :label, ::Perspective::HTML::Elements::Form::Input::InputLabel do
    label.for_input = input
  end

  attr_text_or_number  :error, ::Perspective::HTML::Elements::Form::Input::InputError do
    error.for_input = input
  end

  attr_order           :label, :error, :input

end
