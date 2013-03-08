# -*- encoding : utf-8 -*-

require_relative '../../../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form::Input::URLInput do

  
  it 'packages HTML elements for automated use in a form' do
    
    class ::Perspective::HTML::Form::Input::URLInput 
     
      has_binding?( :input ).should == true
      has_binding?( :value ).should == true
      has_binding?( :label ).should == true
      has_binding?( :error ).should == true
      
      input.«view_class».should == ::Perspective::HTML::Elements::Form::Input::URLInput 
     
    end
    
    ::Perspective::HTML::Form::Input::URLInput.new.instance_eval do
      label_view.for_input.should == input_view
      error_view.for_input.should == input_view
    end
    
  end
  
end
