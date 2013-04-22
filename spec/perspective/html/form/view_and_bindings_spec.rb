# -*- encoding : utf-8 -*-

require_relative '../../../lib/perspective/html/view_model.rb'

require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings_test_setup.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings.rb'

describe ::Perspective::HTML::Form::View do

  let( :bindings_module ) { ::Perspective::HTML::Form::View }
  setup_container_and_bindings_tests  
  
#  it_behaves_like :container_and_bindings

  describe ::Perspective::BindingTypes::HTMLFormViewBindings::ClassBinding do


  end

  describe ::Perspective::BindingTypes::HTMLFormViewBindings::InstanceBinding do
  

  end

end
