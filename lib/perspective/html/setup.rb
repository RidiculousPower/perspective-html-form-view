
module ::Perspective
  extend ::Perspective::HTML::Form::RackApplication
end

module ::Perspective::Bindings::AttributeContainer::HTMLForm::ClassBinding
  include ::Perspective::HTML::Form::Bindings::ClassBinding
end

module ::Perspective::Bindings::AttributeContainer::HTMLForm::InstanceBinding
  include ::Perspective::HTML::Form::Bindings::InstanceBinding
end
