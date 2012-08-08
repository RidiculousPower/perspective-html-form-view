
require_relative '../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form do
  
  it 'adds form auto-processing' do
    
    # declare a form with a nested form and several inputs
    # the nested form should also have a nested form
    class ::Perspective::HTML::Form::MockC
      include ::Perspective::HTML::Form
      attr_text_input :c_inputA do |binding|
        binding.label = 'C - Input A:'
        binding.name = 'c_inputA_view'
      end
      c_inputA.has_binding?( :input ).should == true
      #attr_text_input :c_inputB, ::Perspective::HTML::Form::Input::TextInput do
      #  c_inputB_view.label = 'C - Input B:'
      #end
      #attr_text_input :c_inputC, ::Perspective::HTML::Form::Input::TextInput do
      #  c_inputC_view.label = 'C - Input C:'
      #end
      attr_order :c_inputA#, :c_inputB, :c_inputC
    end
    #class ::Perspective::HTML::Form::MockB
    #  include ::Perspective::HTML::Form
    #  attr_subform    :c, ::Perspective::HTML::Form::MockC
    #  attr_text_input :b_inputA, ::Perspective::HTML::Form::Input::TextInput do
    #    b_inputA_view.label = 'B - Input A:'
    #  end
    #  attr_text_input :b_inputB, ::Perspective::HTML::Form::Input::TextInput do
    #    b_inputB_view.label = 'B - Input B:'
    #  end
    #  attr_text_input :b_inputC, ::Perspective::HTML::Form::Input::TextInput do
    #    b_inputC_view.label = 'B - Input C:'
    #  end
    #  attr_order :b_inputA, :b_inputB, :b_inputC, :c
    #end
    #class ::Perspective::HTML::Form::MockA
    #  include ::Perspective::HTML::Form
    #  attr_subform    :b, ::Perspective::HTML::Form::MockB
    #  attr_text_input :a_inputA, ::Perspective::HTML::Form::Input::TextInput do
    #    a_inputA_view.label = 'A - Input A:'
    #  end
    #  attr_text_input :a_inputB, ::Perspective::HTML::Form::Input::TextInput do
    #    a_inputB_view.label = 'A - Input B:'
    #  end
    #  attr_text_input :a_inputC, ::Perspective::HTML::Form::Input::TextInput do
    #    a_inputC_view.label = 'A - Input C:'
    #  end
#   #   puts 'string: ' + b.c.c_inputA.__route_string__.to_s
    #  attr_order :a_inputA, :a_inputB, :a_inputC, :b
    #end
    
    form = ::Perspective::HTML::Form::MockC.new
    form.rendering_empty!
    # render form
    # check that each input is named appropriately for its binding path
    form.__bindings__
    form.__local_aliases_to_bindings__
    html_node = form.to_html_node
    puts 'form: ' + html_node.to_s
    
    # simulate POST and ensure proper processing/validation
    
  end
  
end
