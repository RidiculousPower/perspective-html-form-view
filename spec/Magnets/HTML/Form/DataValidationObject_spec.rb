
require_relative '../../../../lib/magnets-html-form.rb'

describe ::Magnets::HTML::Form::DataValidationObject do

  #####################################
  #  self.new_validated_object_class  #
  #  self.view_class                  #
  #  self.define_input                #
  #  self.define_subview             #
  #  initialize                       #
  #####################################
  
  it 'can create a validated data object class for a form or view class' do
    class ::Magnets::HTML::Form::DataValidationObject::MockView2
      include ::Magnets::HTML::View
    end
    class ::Magnets::HTML::Form::DataValidationObject::MockView
      include ::Magnets::HTML::View
      attr_view :some_subview, ::Magnets::HTML::Form::DataValidationObject::MockView2
    end
    new_instance = ::Magnets::HTML::Form::DataValidationObject.new_validated_object_class( ::Magnets::HTML::Form::DataValidationObject::MockView )
    new_instance.view_class.should == ::Magnets::HTML::Form::DataValidationObject::MockView
    new_instance.define_input( :some_input )
    new_instance.respond_to?( :some_input ).should == false
    new_instance.method_defined?( :some_input ).should == true
    new_instance.method_defined?( :some_input= ).should == true
    new_instance.define_subview( :some_subview )
    new_instance.method_defined?( :some_subview ).should == true
    new_instance.method_defined?( :some_subview= ).should == false
    data_object_instance = new_instance.new
    data_object_instance.some_input.should == nil
    data_object_instance.some_subview.should_not == nil
  end

end
