# -*- encoding : utf-8 -*-

require_relative '../../../../lib/perspective/html/form/view.rb'

describe ::Perspective::HTML::Form::View do
  
  # declare a form with a nested form and several inputs
  # the nested form should also have a nested form

  #class ::Perspective::HTML::Form::View::MockC
  #  include ::Perspective::HTML::Form::View
  #  attr_text_input :c_inputA, :c_inputB, :c_inputC
  #  puts 'wtf: ' << «bindings».keys.to_s
  #  c_inputA.label = 'C - Input A:'
  #  c_inputB.label = 'C - Input B:'
  #  c_inputC.label = 'C - Input C:'
  #  attr_order :c_inputA, :c_inputB, :c_inputC
  #end
  #
  #class ::Perspective::HTML::Form::View::MockB
  #  include ::Perspective::HTML::Form::View
  #  attr_form :c, ::Perspective::HTML::Form::View::MockC
  #  attr_text_input :b_inputA, :b_inputB, :b_inputC
  #  b_inputA.label = 'B - Input A:'
  #  b_inputB.label = 'B - Input B:'
  #  b_inputC.label = 'B - Input C:'
  #  attr_order :b_inputA, :b_inputB, :b_inputC, :c
  #end
  #
  #class ::Perspective::HTML::Form::View::MockA
  #  include ::Perspective::HTML::Form::View
  #  attr_form :b, ::Perspective::HTML::Form::View::MockB
  #  attr_text_input :a_inputA, :a_inputB, :a_inputC
  #  a_inputA.label = 'A - Input A:'
  #  a_inputB.label = 'A - Input B:'
  #  a_inputC.label = 'A - Input C:'
  #  attr_order :a_inputA, :a_inputB, :a_inputC, :b
  #end

  it 'breaks' do
    class ::Perspective::HTML::Form::View::MockC
      include ::Perspective::HTML::Form::View
      attr_text_input :c_inputA, :c_inputB, :c_inputC
      c_inputA.label = 'C - Input A:'
      c_inputB.label = 'C - Input B:'
      c_inputC.label = 'C - Input C:'
      attr_order :c_inputA, :c_inputB, :c_inputC
    end
  end
  
  #it 'permits nesting of forms; nested forms are rendered as divs' do
  #
  #  form = ::Perspective::HTML::Form::View::MockA.new
  #
  #  form.rendering_empty!
  #  
  #  form.b.b_inputA.view.rendering_empty!
  #
  #  # render form
  #  html_node = form.to_html_node
  #
  #  # check that each input is named appropriately for its binding path
  #
  #  html_node.name.should == 'form'
  #
  #  html_node.children[0].name.should == 'div'
  #  html_node.children[0][ 'id' ].should == 'a_inputA'
  #  html_node.children[0][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #  html_node.children[1].name.should == 'div'
  #  html_node.children[1][ 'id' ].should == 'a_inputB'
  #  html_node.children[1][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #  html_node.children[2].name.should == 'div'
  #  html_node.children[2][ 'id' ].should == 'a_inputC'
  #  html_node.children[2][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #  html_node.children[3].name.should == 'div'
  #  html_node.children[3][ 'id' ].should == 'b'
  #  html_node.children[3][ 'class' ].should == 'Perspective::HTML::Form::View::MockB'
  #
  #    html_node.children[3].children[0].name.should == 'div'
  #    html_node.children[3].children[0][ 'id' ].should == 'b::b_inputA'
  #    html_node.children[3].children[0][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #    html_node.children[3].children[1].name.should == 'div'
  #    html_node.children[3].children[1][ 'id' ].should == 'b::b_inputB'
  #    html_node.children[3].children[1][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #    html_node.children[3].children[2].name.should == 'div'
  #    html_node.children[3].children[2][ 'id' ].should == 'b::b_inputC'
  #    html_node.children[3].children[2][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #    html_node.children[3].children[3].name.should == 'div'
  #    html_node.children[3].children[3][ 'id' ].should == 'b::c'
  #    html_node.children[3].children[3][ 'class' ].should == 'Perspective::HTML::Form::View::MockC'
  #
  #      html_node.children[3].children[3].children[0].name.should == 'div'
  #      html_node.children[3].children[3].children[0][ 'id' ].should == 'b::c::c_inputA'
  #      html_node.children[3].children[3].children[0][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #      html_node.children[3].children[3].children[1].name.should == 'div'
  #      html_node.children[3].children[3].children[1][ 'id' ].should == 'b::c::c_inputB'
  #      html_node.children[3].children[3].children[1][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #      html_node.children[3].children[3].children[2].name.should == 'div'
  #      html_node.children[3].children[3].children[2][ 'id' ].should == 'b::c::c_inputC'
  #      html_node.children[3].children[3].children[2][ 'class' ].should == 'Perspective::HTML::Form::View::Input::TextInput'
  #
  #  html_node.children[4].name.should == 'input'
  #  html_node.children[4][ 'name' ].should == ::Perspective::HTML::Form::View.«input_name_for_hidden_input_for_form_route»
  #  
  #end
  #
  #it 'adds form auto-processing' do
  #  
  #  ::Perspective.root = ::Perspective::HTML::Form::View::MockA
  #
  #  mock_request = ::Rack::MockRequest.new( ::Perspective )
  #  
  #  delimiter = ::Perspective::Bindings::RouteDelimiter
  #  
  #  post_hash = { 'a_inputA' + delimiter + 'input'                                     => 'value_A',
  #                'a_inputB' + delimiter + 'input'                                     => 'value_B',
  #                'a_inputC' + delimiter + 'input'                                     => 'value_C',
  #                'b' + delimiter + 'b_inputA' + delimiter + 'input'                   => 'value_b_A',
  #                'b' + delimiter + 'b_inputB' + delimiter + 'input'                   => 'value_b_B',
  #                'b' + delimiter + 'b_inputC' + delimiter + 'input'                   => 'value_b_C',
  #                'b' + delimiter + 'c' + delimiter + 'c_inputA' + delimiter + 'input' => 'value_bc_A',
  #                'b' + delimiter + 'c' + delimiter + 'c_inputB' + delimiter + 'input' => 'value_bc_B',
  #                'b' + delimiter + 'c' + delimiter + 'c_inputC' + delimiter + 'input' => 'value_bc_C',
  #                ::Perspective::HTML::Form::View.«input_name_for_hidden_input_for_form_route» => '' }
  #
  #  mock_response = mock_request.post( 'some/path', :params => post_hash )
  #  
  #  processed_form = ::Perspective.root_instance
  #  
  #  processed_form.a_inputA.should == 'value_A'
  #  
  #  
  #end
  
end
