
require_relative '../../../lib/magnets-form.rb'

describe ::Magnets::HTML::Form::Request do
  
  ###########################
	#  initialize_parameters  #
  ###########################
  
  it 'it can turn a hash of PUT/POST data with keys named path-to-binding into a nested data validation object' do
    class ::Magnets::Request::Mock
      include ::Magnets::HTML::Form::Request

      class MockSubViewPathToSomeOtherBinding
        include ::Magnets::HTML::Form
        attr_text_input :one, :two
        __data_validation_class__.method_defined?( :one ).should == true
        __data_validation_class__.method_defined?( :two ).should == true
        __has_input__?.should == true
      end
      class MockSubViewPathToSomeOther
        include ::Magnets::Abstract::View
        attr_form :binding, ::Magnets::Request::Mock::MockSubViewPathToSomeOtherBinding
        __has_input__?.should == true
        __data_validation_class__.method_defined?( :binding ).should == true
      end
      class MockSubViewPathToSome
        include ::Magnets::Abstract::View
        attr_view :other, ::Magnets::Request::Mock::MockSubViewPathToSomeOther
        __data_validation_class__.method_defined?( :other ).should == true
        __has_input__?.should == true
      end
      class MockSubViewPathToAnotherBinding
        include ::Magnets::HTML::Form
        attr_text_input :one, :two, :three
        __data_validation_class__.method_defined?( :one ).should == true
        __data_validation_class__.method_defined?( :two ).should == true
        __data_validation_class__.method_defined?( :three ).should == true
        __has_input__?.should == true
      end
      class MockSubViewPathToAnother
        include ::Magnets::Abstract::View
        attr_view :binding, ::Magnets::Request::Mock::MockSubViewPathToAnotherBinding
        __data_validation_class__.method_defined?( :binding ).should == true
        __has_input__?.should == true
      end
      class MockSubViewPathToBinding
        include ::Magnets::HTML::Form
        attr_text_input :one, :two, :three
        __data_validation_class__.method_defined?( :one ).should == true
        __data_validation_class__.method_defined?( :two ).should == true
        __data_validation_class__.method_defined?( :three ).should == true
        __has_input__?.should == true
      end
      class MockSubViewPathTo
        include ::Magnets::Abstract::View
        attr_view :binding, ::Magnets::Request::Mock::MockSubViewPathToBinding
        attr_view :another, ::Magnets::Request::Mock::MockSubViewPathToAnother
        attr_view :some, ::Magnets::Request::Mock::MockSubViewPathToSome
        __data_validation_class__.method_defined?( :binding ).should == true
        __data_validation_class__.method_defined?( :another ).should == true
        __data_validation_class__.method_defined?( :some ).should == true
        __has_input__?.should == true
      end
      class MockSubViewPath
        include ::Magnets::Abstract::View
        attr_view :to, ::Magnets::Request::Mock::MockSubViewPathTo
        __data_validation_class__.method_defined?( :to ).should == true
        __has_input__?.should == true
      end
      class MockForm
        include ::Magnets::HTML::Form
        attr_view :path, ::Magnets::Request::Mock::MockSubViewPath
        __data_validation_class__.method_defined?( :path ).should == true
        __has_input__?.should == true
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
    
    ::Magnets::Request::Mock.new.instance_eval do

      initialize_parameters( ::Magnets::Request::Mock::MockForm )

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
