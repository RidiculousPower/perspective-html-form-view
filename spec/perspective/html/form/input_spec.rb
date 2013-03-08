# -*- encoding : utf-8 -*-

require_relative '../../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form::Input do
  
  it 'packages HTML elements for automated use in a form' do

    class ::Perspective::HTML::Form::Input::MockInput 
     
      include ::Perspective::HTML::Form::Input
      
      has_binding?( :input ).should == true
      has_binding?( :value ).should == true
      has_binding?( :label ).should == true
      has_binding?( :error ).should == true
      
      input.configure do |input_instance|
        self.name = 'path-to-generic_input'
      end
      
    end

    ::Perspective::HTML::Form::Input::MockInput.new.instance_eval do
      label.text = 'Generic Input'
      html_node = to_html_node
      html_node.children[2][ 'name' ].should == 'path-to-generic_input'
    end
    
  end
  
end
