
require_relative '../../../lib/magnets-form.rb'

describe ::Magnets::HTML::Form::Input do
  
  it 'packages HTML elements for automated use in a form' do
    
    class ::Magnets::HTML::Form::Input::Mock
      
      include ::Magnets::HTML::Form::Input
      
      has_binding?( :input ).should == true
      has_binding?( :input_view ).should == false
      has_binding?( :value ).should == true
      has_binding?( :value_view ).should == false
      has_binding?( :label ).should == true
      has_binding?( :label_view ).should == true
      has_binding?( :error ).should == true
      has_binding?( :error_view ).should == true
      
      input_configuration_proc = Proc.new do |input_instance|
        self.name = 'path-to-generic_input'
      end
      __configuration_procs__.unshift( input_configuration_proc )
      
    end
    
    ::Magnets::HTML::Form::Input::Mock.new.instance_eval do
      label_view.for_input.should == input
      error_view.for_input.should == input
      label_view.text = 'Generic Input'
      html_node = to_html_node
      html_node.children[2][ 'name' ].should == 'path-to-generic_input'
    end
    
  end
  
end
