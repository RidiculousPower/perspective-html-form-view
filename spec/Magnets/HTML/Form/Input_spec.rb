
require_relative '../../../../lib/magnets-html-form.rb'

describe ::Magnets::HTML::Form::Input do
  
  it 'packages HTML elements for automated use in a form' do

    class ::Magnets::HTML::Form::Input::MockInput 
     
      include ::Magnets::HTML::Form::Input
      
      has_binding?( :input ).should == true
      method_defined?( :input_view ).should == true
      has_binding?( :value ).should == true
      method_defined?( :value_view ).should == true
      has_binding?( :label ).should == true
      method_defined?( :label_view ).should == true
      has_binding?( :error ).should == true
      method_defined?( :error_view ).should == true
      
      input.configure do |input_instance|
        self.name = 'path-to-generic_input'
      end
      
    end

    ::Magnets::HTML::Form::Input::MockInput.new.instance_eval do
      label_view.for_input.should == input_view
      error_view.for_input.should == input_view
      label_view.text = 'Generic Input'
      html_node = to_html_node
      html_node.children[2][ 'name' ].should == 'path-to-generic_input'
    end
    
  end
  
end
