
require_relative '../../../../lib/magnets-form.rb'

describe ::Magnets::HTML::Form::Input::Month do
  
  it 'packages HTML elements for automated use in a form' do
    
    class ::Magnets::HTML::Form::Input::Month
      
      has_binding?( :input ).should == true
      has_binding?( :input_view ).should == false
      has_binding?( :value ).should == true
      has_binding?( :value_view ).should == false
      has_binding?( :label ).should == true
      has_binding?( :label_view ).should == true
      has_binding?( :error ).should == true
      has_binding?( :error_view ).should == true
      
      input.__view_class__.should == ::Magnets::HTML::Elements::Form::Input::Month
      
    end
    
    ::Magnets::HTML::Form::Input::Month.new.instance_eval do
      label_view.for_input.should == input
      error_view.for_input.should == input
    end
    
  end
  
end
