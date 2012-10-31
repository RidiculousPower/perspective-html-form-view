
module ::Perspective
  extend ::Perspective::HTML::Form::RackApplication
end

module ::Perspective::Bindings::AttributeContainer::HTMLForm::ClassBinding
  include ::Perspective::HTML::Form::FormBinding::ClassBinding
end

module ::Perspective::Bindings::AttributeContainer::HTMLForm::ClassBinding::NestedClassBinding
  include ::Perspective::HTML::Form::FormBinding::ClassBinding::NestedClassBinding
end

module ::Perspective::Bindings::AttributeContainer::HTMLForm::InstanceBinding
  include ::Perspective::HTML::Form::FormBinding::InstanceBinding
end

module ::Perspective::Bindings::AttributeContainer::HTMLFormInput::ClassBinding
  include ::Perspective::HTML::Form::InputBinding::ClassBinding
end

module ::Perspective::Bindings::AttributeContainer::HTMLFormInput::ClassBinding::NestedClassBinding
  include ::Perspective::HTML::Form::InputBinding::ClassBinding::NestedClassBinding
end

module ::Perspective::Bindings::AttributeContainer::HTMLFormInput::InstanceBinding
  include ::Perspective::HTML::Form::InputBinding::InstanceBinding
end

module ::Perspective::HTML::View::ClassInstance
  include ::Perspective::Bindings::AttributeContainer::HTMLForm
end
