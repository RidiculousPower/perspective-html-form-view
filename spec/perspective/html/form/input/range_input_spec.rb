
require_relative '../../../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form::Input::RangeInput do

  
  it 'packages HTML elements for automated use in a form' do
    
    class ::Perspective::HTML::Form::Input::RangeInput 
     
      has_binding?( :input ).should == true
      method_defined?( :input_view ).should == true
      has_binding?( :value ).should == true
      method_defined?( :value_view ).should == true
      has_binding?( :label ).should == true
      method_defined?( :label_view ).should == true
      has_binding?( :error ).should == true
      method_defined?( :error_view ).should == true
      
      input.__view_class__.should == ::Perspective::HTML::Elements::Form::Input::RangeInput 
     
    end
    
    ::Perspective::HTML::Form::Input::RangeInput.new.instance_eval do
      label_view.for_input.should == input_view
      error_view.for_input.should == input_view
    end
    
  end
  
end
