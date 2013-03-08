# -*- encoding : utf-8 -*-

require_relative '../../../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form::View::Input::WeekInput do

  
  it 'packages HTML elements for automated use in a form' do
    
    class ::Perspective::HTML::Form::View::Input::WeekInput 
     
      has_binding?( :input ).should == true
      has_binding?( :value ).should == true
      has_binding?( :label ).should == true
      has_binding?( :error ).should == true
      
      input.«view_class».should == ::Perspective::HTML::Elements::Form::View::Input::WeekInput 
     
    end
    
    ::Perspective::HTML::Form::View::Input::WeekInput.new.instance_eval do
      label.for_input.should == input
      error.for_input.should == input
    end
    
  end
  
end
