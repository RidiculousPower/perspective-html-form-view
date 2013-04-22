# -*- encoding : utf-8 -*-

require_relative '../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form do
  
  before :each do
    
    # declare a form with a nested form and several inputs
    # the nested form should also have a nested form
    class ::Perspective::HTML::Form::View::MockC
      include ::Perspective::HTML::Form
      attr_text_input :c_inputA do
        c_inputA.view.label.«value» = 'C - Input A:'
      end
      # now we need input methods defined separately
      c_inputA.has_binding?( :input ).should == true
      attr_text_input :c_inputB, ::Perspective::HTML::Form::View::Input::TextInput do
        c_inputB.view.label.«value» = 'C - Input B:'
      end
      attr_text_input :c_inputC, ::Perspective::HTML::Form::View::Input::TextInput do
        c_inputC.view.label.«value» = 'C - Input C:'
      end
      attr_order :c_inputA, :c_inputB, :c_inputC
    end
    class ::Perspective::HTML::Form::View::MockB
      include ::Perspective::HTML::Form
      attr_form    :c, ::Perspective::HTML::Form::View::MockC
      attr_text_input :b_inputA do
        b_inputA.view.label.«value» = 'B - Input A:'
      end
      attr_text_input :b_inputB do
        b_inputB.view.label.«value» = 'B - Input B:'
      end
      attr_text_input :b_inputC do
        b_inputC.view.label.«value» = 'B - Input C:'
      end
      attr_order :b_inputA, :b_inputB, :b_inputC, :c
    end
    class ::Perspective::HTML::Form::View::MockA
      include ::Perspective::HTML::Form
      attr_form    :b, ::Perspective::HTML::Form::View::MockB
      attr_text_input :a_inputA do
        a_inputA.view.label.«value» = 'A - Input A:'
      end
      attr_text_input :a_inputB do
        a_inputB.view.label.«value» = 'A - Input B:'
      end
      attr_text_input :a_inputC do
        a_inputC.view.label.«value» = 'A - Input C:'
      end
      attr_order :a_inputA, :a_inputB, :a_inputC, :b
    end
  
  end
  
  it 'permits nesting of forms; nested forms are rendered as divs' do

    form = ::Perspective::HTML::Form::View::MockA.new

    form.rendering_empty!
    
    form.b.b_inputA.view.rendering_empty!

    # render form
    html_node = form.to_html_node

    # check that each input is named appropriately for its binding path

    html_node.name.should == 'form'

    html_node.children[0].name.should == 'div'
    html_node.children[0][ 'id' ].should == 'a_inputA'
    html_node.children[0][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

    html_node.children[1].name.should == 'div'
    html_node.children[1][ 'id' ].should == 'a_inputB'
    html_node.children[1][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

    html_node.children[2].name.should == 'div'
    html_node.children[2][ 'id' ].should == 'a_inputC'
    html_node.children[2][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

    html_node.children[3].name.should == 'div'
    html_node.children[3][ 'id' ].should == 'b'
    html_node.children[3][ 'class' ].should == 'Perspective::HTML::Form::View::MockB'

      html_node.children[3].children[0].name.should == 'div'
      html_node.children[3].children[0][ 'id' ].should == 'b::b_inputA'
      html_node.children[3].children[0][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

      html_node.children[3].children[1].name.should == 'div'
      html_node.children[3].children[1][ 'id' ].should == 'b::b_inputB'
      html_node.children[3].children[1][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

      html_node.children[3].children[2].name.should == 'div'
      html_node.children[3].children[2][ 'id' ].should == 'b::b_inputC'
      html_node.children[3].children[2][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

      html_node.children[3].children[3].name.should == 'div'
      html_node.children[3].children[3][ 'id' ].should == 'b::c'
      html_node.children[3].children[3][ 'class' ].should == 'Perspective::HTML::Form::View::MockC'

        html_node.children[3].children[3].children[0].name.should == 'div'
        html_node.children[3].children[3].children[0][ 'id' ].should == 'b::c::c_inputA'
        html_node.children[3].children[3].children[0][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

        html_node.children[3].children[3].children[1].name.should == 'div'
        html_node.children[3].children[3].children[1][ 'id' ].should == 'b::c::c_inputB'
        html_node.children[3].children[3].children[1][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

        html_node.children[3].children[3].children[2].name.should == 'div'
        html_node.children[3].children[3].children[2][ 'id' ].should == 'b::c::c_inputC'
        html_node.children[3].children[3].children[2][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'

    html_node.children[4].name.should == 'input'
    html_node.children[4][ 'name' ].should == ::Perspective::HTML::Form::View.«input_name_for_hidden_input_for_form_route»
    
  end

  it 'adds form auto-processing' do
    
    # simulate POST and ensure proper processing/validation
    
    ::Perspective.root = ::Perspective::HTML::Form::View::MockA

    mock_request = ::Rack::MockRequest.new( ::Perspective )
    
    delimiter = ::Perspective::Bindings::RouteDelimiter
    
    post_hash = { 'a_inputA' + delimiter + 'input'                                     => 'value_A',
                  'a_inputB' + delimiter + 'input'                                     => 'value_B',
                  'a_inputC' + delimiter + 'input'                                     => 'value_C',
                  'b' + delimiter + 'b_inputA' + delimiter + 'input'                   => 'value_b_A',
                  'b' + delimiter + 'b_inputB' + delimiter + 'input'                   => 'value_b_B',
                  'b' + delimiter + 'b_inputC' + delimiter + 'input'                   => 'value_b_C',
                  'b' + delimiter + 'c' + delimiter + 'c_inputA' + delimiter + 'input' => 'value_bc_A',
                  'b' + delimiter + 'c' + delimiter + 'c_inputB' + delimiter + 'input' => 'value_bc_B',
                  'b' + delimiter + 'c' + delimiter + 'c_inputC' + delimiter + 'input' => 'value_bc_C',
                  ::Perspective::HTML::Form::View.«input_name_for_hidden_input_for_form_route» => '' }

    mock_response = mock_request.post( 'some/path', :params => post_hash )
    
    processed_form = ::Perspective.root_instance
    
    processed_form.a_inputA.input.should == 'value_A'

    # we want:
#    puts 'owner: ' + processed_form.a_inputA.«method»( :«value» ).owner.to_s
    processed_form.a_inputA.should == 'value_A'
    
    
  end
  
end
