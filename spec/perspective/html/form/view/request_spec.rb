# -*- encoding : utf-8 -*-

require_relative '../../../../lib/perspective/html/form.rb'

describe ::Perspective::HTML::Form::View::Request do
  
  ################################
	#  initialize_form_parameters  #
  ################################
  
  it 'it can turn a hash of PUT/POST data with keys named path-to-binding into a nested data validation object' do
    class ::Perspective::Request::Mock
      include ::Perspective::HTML::Form::View::Request

      class MockSubViewPathToSomeOtherBinding
        include ::Perspective::HTML::Form
        attr_text_input :one, :two
        self::DataValidationClass.method_defined?( :one ).should == true
        self::DataValidationClass.method_defined?( :two ).should == true
        has_input?.should == true
      end
      class MockSubViewPathToSomeOther
        include ::Perspective::View
        attr_form :binding, ::Perspective::Request::Mock::MockSubViewPathToSomeOtherBinding
        has_input?.should == true
        self::DataValidationClass.method_defined?( :binding ).should == true
      end
      class MockSubViewPathToSome
        include ::Perspective::View
        attr_view :other, ::Perspective::Request::Mock::MockSubViewPathToSomeOther
        self::DataValidationClass.method_defined?( :other ).should == true
        has_input?.should == true
      end
      class MockSubViewPathToAnotherBinding
        include ::Perspective::HTML::Form
        attr_text_input :one, :two, :three
        self::DataValidationClass.method_defined?( :one ).should == true
        self::DataValidationClass.method_defined?( :two ).should == true
        self::DataValidationClass.method_defined?( :three ).should == true
        has_input?.should == true
      end
      class MockSubViewPathToAnother
        include ::Perspective::View
        attr_view :binding, ::Perspective::Request::Mock::MockSubViewPathToAnotherBinding
        self::DataValidationClass.method_defined?( :binding ).should == true
        has_input?.should == true
      end
      class MockSubViewPathToBinding
        include ::Perspective::HTML::Form
        attr_text_input :one, :two, :three
        self::DataValidationClass.method_defined?( :one ).should == true
        self::DataValidationClass.method_defined?( :two ).should == true
        self::DataValidationClass.method_defined?( :three ).should == true
        has_input?.should == true
      end
      class MockSubViewPathTo
        include ::Perspective::View
        attr_view :binding, ::Perspective::Request::Mock::MockSubViewPathToBinding
        attr_view :another, ::Perspective::Request::Mock::MockSubViewPathToAnother
        attr_view :some, ::Perspective::Request::Mock::MockSubViewPathToSome
        self::DataValidationClass.method_defined?( :binding ).should == true
        self::DataValidationClass.method_defined?( :another ).should == true
        self::DataValidationClass.method_defined?( :some ).should == true
        has_input?.should == true
      end
      class MockSubViewPath
        include ::Perspective::View
        attr_view :to, ::Perspective::Request::Mock::MockSubViewPathTo
        self::DataValidationClass.method_defined?( :to ).should == true
        has_input?.should == true
      end
      class MockForm
        include ::Perspective::HTML::Form
        attr_view :path, ::Perspective::Request::Mock::MockSubViewPath
        self::DataValidationClass.method_defined?( :path ).should == true
        has_input?.should == true
      end

      def raw_parameters
        return @raw_parameters ||= { 'path-to-binding-one'             => :one,
                                     'path-to-binding-two'             => :two,
                                     'path-to-binding-three'           => :three,
                                     'path-to-another-binding-one'     => :four,
                                     'path-to-another-binding-two'     => :five,
                                     'path-to-another-binding-three'   => :six,
                                     'path-to-some-other-binding-one'  => :seven,
                                     'path-to-some-other-binding-two'  => :eight }
      end

    end
    
    ::Perspective::Request::Mock.new.instance_eval do

      initialize_form_parameters( ::Perspective::Request::Mock::MockForm )

      @parameters.respond_to?( :path ).should == true
      @parameters.path.respond_to?( :to ).should == true
      @parameters.path.to.respond_to?( :binding ).should == true
      @parameters.path.to.binding.respond_to?( :one ).should == true
      @parameters.path.to.binding.respond_to?( :two ).should == true
      @parameters.path.to.binding.respond_to?( :three ).should == true
      @parameters.path.to.respond_to?( :another ).should == true
      @parameters.path.to.another.respond_to?( :binding ).should == true
      @parameters.path.to.another.binding.respond_to?( :one ).should == true
      @parameters.path.to.another.binding.respond_to?( :two ).should == true
      @parameters.path.to.another.binding.respond_to?( :three ).should == true
      @parameters.path.to.respond_to?( :some ).should == true
      @parameters.path.to.some.respond_to?( :other ).should == true
      @parameters.path.to.some.other.respond_to?( :binding ).should == true
      @parameters.path.to.some.other.binding.respond_to?( :one ).should == true
      @parameters.path.to.some.other.binding.respond_to?( :two ).should == true

      @parameters.path.to.binding.one.should == :one
      @parameters.path.to.binding.two.should == :two
      @parameters.path.to.binding.three.should == :three
      @parameters.path.to.another.binding.one.should == :four
      @parameters.path.to.another.binding.two.should == :five
      @parameters.path.to.another.binding.three.should == :six
      @parameters.path.to.some.other.binding.one.should == :seven
      @parameters.path.to.some.other.binding.two.should == :eight
      
    end
    
  end
  
end
