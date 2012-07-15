
module ::Magnets
  extend ::Magnets::HTML::Form::RackApplication
end

module ::Magnets::Bindings::AttributeContainer::HTMLForm::ClassBinding
  include ::Magnets::HTML::Form::Bindings::ClassBinding
end

module ::Magnets::Bindings::AttributeContainer::HTMLForm::InstanceBinding
  include ::Magnets::HTML::Form::Bindings::InstanceBinding
end
