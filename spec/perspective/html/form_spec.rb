
require_relative '../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form do
  
  before :all do
    
    # declare a form with a nested form and several inputs
    # the nested form should also have a nested form
    class ::Perspective::HTML::Form::MockC
      include ::Perspective::HTML::Form
      attr_text_input :c_inputA do
        c_inputA.view.label.value = 'C - Input A:'
      end
      # now we need input methods defined separately
      c_inputA.has_binding?( :input ).should == true
      attr_text_input :c_inputB, ::Perspective::HTML::Form::Input::TextInput do
        c_inputB.view.label.value = 'C - Input B:'
      end
      attr_text_input :c_inputC, ::Perspective::HTML::Form::Input::TextInput do
        c_inputC.view.label.value = 'C - Input C:'
      end
      attr_order :c_inputA, :c_inputB, :c_inputC
    end
    class ::Perspective::HTML::Form::MockB
      include ::Perspective::HTML::Form
      attr_form    :c, ::Perspective::HTML::Form::MockC
      attr_text_input :b_inputA do
        b_inputA.view.label.value = 'B - Input A:'
      end
      attr_text_input :b_inputB do
        b_inputB.view.label.value = 'B - Input B:'
      end
      attr_text_input :b_inputC do
        b_inputC.view.label.value = 'B - Input C:'
      end
      attr_order :b_inputA, :b_inputB, :b_inputC, :c
    end
    class ::Perspective::HTML::Form::MockA
      include ::Perspective::HTML::Form
      attr_form    :b, ::Perspective::HTML::Form::MockB
      attr_text_input :a_inputA do
        a_inputA.view.label.value = 'A - Input A:'
      end
      attr_text_input :a_inputB do
        a_inputB.view.label.value = 'A - Input B:'
      end
      attr_text_input :a_inputC do
        a_inputC.view.label.value = 'A - Input C:'
      end
      attr_order :a_inputA, :a_inputB, :a_inputC, :b
    end
  
  end
  
  it 'permits nesting of forms; nested forms are rendered as divs' do

    form = ::Perspective::HTML::Form::MockA.new

    form.rendering_empty!
    
    form.b.b_inputA.view.rendering_empty!

    # render form
    html_node = form.to_html_node

    # check that each input is named appropriately for its binding path

    html_node.name.should == 'form'

    html_node.children[0].name.should == 'div'
    html_node.children[0][ 'id' ].should == 'a_inputA'
    html_node.children[0][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

    html_node.children[1].name.should == 'div'
    html_node.children[1][ 'id' ].should == 'a_inputB'
    html_node.children[1][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

    html_node.children[2].name.should == 'div'
    html_node.children[2][ 'id' ].should == 'a_inputC'
    html_node.children[2][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

    html_node.children[3].name.should == 'div'
    html_node.children[3][ 'id' ].should == 'b'
    html_node.children[3][ 'class' ].should == 'Perspective::HTML::Form::MockB'

      html_node.children[3].children[0].name.should == 'div'
      html_node.children[3].children[0][ 'id' ].should == 'b::b_inputA'
      html_node.children[3].children[0][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

      html_node.children[3].children[1].name.should == 'div'
      html_node.children[3].children[1][ 'id' ].should == 'b::b_inputB'
      html_node.children[3].children[1][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

      html_node.children[3].children[2].name.should == 'div'
      html_node.children[3].children[2][ 'id' ].should == 'b::b_inputC'
      html_node.children[3].children[2][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

      html_node.children[3].children[3].name.should == 'div'
      html_node.children[3].children[3][ 'id' ].should == 'b::c'
      html_node.children[3].children[3][ 'class' ].should == 'Perspective::HTML::Form::MockC'

        html_node.children[3].children[3].children[0].name.should == 'div'
        html_node.children[3].children[3].children[0][ 'id' ].should == 'b::c::c_inputA'
        html_node.children[3].children[3].children[0][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

        html_node.children[3].children[3].children[1].name.should == 'div'
        html_node.children[3].children[3].children[1][ 'id' ].should == 'b::c::c_inputB'
        html_node.children[3].children[3].children[1][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

        html_node.children[3].children[3].children[2].name.should == 'div'
        html_node.children[3].children[3].children[2][ 'id' ].should == 'b::c::c_inputC'
        html_node.children[3].children[3].children[2][ 'class' ].should == 'Perspective::HTML::Form::Input::TextInput'

  end

  it 'adds form auto-processing' do
    
    # simulate POST and ensure proper processing/validation
    
    ::Perspective.root = ::Perspective::HTML::Form::MockA
    mock_request = ::Rack::MockRequest.new( ::Perspective )
    mock_response = mock_request.get( 'some/other/path' )
    
  end
  
end
