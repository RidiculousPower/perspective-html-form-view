
require_relative '../../lib/magnets-form.rb'

describe ::Magnets::HTML::Form do
  
  it 'adds form auto-processing' do
    
    # declare a form with a nested form and several inputs
    # the nested form should also have a nested form
    class ::Magnets::HTML::Form::MockC
      include ::Magnets::HTML::Form
      attr_text_input :c_inputA do
        c_inputA.label = 'C - Input A:'
      end
      attr_text_input :c_inputB do
        c_inputB.label = 'C - Input B:'
      end
      attr_text_input :c_inputC do
        c_inputC.label = 'C - Input C:'
      end
      attr_order :c_inputA, :c_inputB, :c_inputC
    end
    class ::Magnets::HTML::Form::MockB
      include ::Magnets::HTML::Form
      attr_subform    :c, ::Magnets::HTML::Form::MockC
      attr_text_input :b_inputA do
        b_inputA.label = 'B - Input A:'
      end
      attr_text_input :b_inputB do
        b_inputB.label = 'B - Input B:'
      end
      attr_text_input :b_inputC do
        b_inputC.label = 'B - Input C:'
      end
      attr_order :b_inputA, :b_inputB, :b_inputC, :c
    end
    class ::Magnets::HTML::Form::MockA
      include ::Magnets::HTML::Form
      attr_subform    :b, ::Magnets::HTML::Form::MockB
      attr_text_input :a_inputA do
        a_inputA.label = 'A - Input A:'
      end
      attr_text_input :a_inputB do
        a_inputB.label = 'A - Input B:'
      end
      attr_text_input :a_inputC do
        a_inputC.label = 'A - Input C:'
      end
      puts 'string: ' + b.c.c_inputA.__route_string__.to_s
      attr_order :a_inputA, :a_inputB, :a_inputC, :b
    end
    
    form = ::Magnets::HTML::Form::MockA.new
    
    # render form
    # check that each input is named appropriately for its binding path
    html_node = form.to_html_node
    puts 'form: ' + html_node.to_s
    
    # simulate POST and ensure proper processing/validation
    
  end
  
end
