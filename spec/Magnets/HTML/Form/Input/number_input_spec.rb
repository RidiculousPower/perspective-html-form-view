
require_relative '../../../../../lib/magnets-html-form.rb'

describe ::Magnets::HTML::Form::Input::NumberInput do

  
  it 'packages HTML elements for automated use in a form' do
    
    class ::Magnets::HTML::Form::Input::NumberInput 
     
      has_binding?( :input ).should == true
      method_defined?( :input_view ).should == true
      has_binding?( :value ).should == true
      method_defined?( :value_view ).should == true
      has_binding?( :label ).should == true
      method_defined?( :label_view ).should == true
      has_binding?( :error ).should == true
      method_defined?( :error_view ).should == true
      
      input.__view_class__.should == ::Magnets::HTML::Elements::Form::Input::NumberInput 
     
    end
    
    ::Magnets::HTML::Form::Input::NumberInput.new.instance_eval do
      label_view.for_input.should == input_view
      error_view.for_input.should == input_view
    end
    
  end
  
end
