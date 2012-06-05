
module ::Magnets::HTML::Form::ClassInstance

  ::Magnets::Bindings::Attributes.define_container_type( :HTML_form, :HTML_view_model )
  
  include ::Magnets::Bindings::AttributeContainer::HTMLForm
  
  #include ::Magnets::HTML::Form::ClassInstance::ButtonInput
  #include ::Magnets::HTML::Form::ClassInstance::CheckboxInput
  #include ::Magnets::HTML::Form::ClassInstance::ColorInput
  #include ::Magnets::HTML::Form::ClassInstance::DataListInput
  #include ::Magnets::HTML::Form::ClassInstance::DateInput
  #include ::Magnets::HTML::Form::ClassInstance::DateTimeInput 
  #include ::Magnets::HTML::Form::ClassInstance::EmailInput
  #include ::Magnets::HTML::Form::ClassInstance::FileUploadInput
  #include ::Magnets::HTML::Form::ClassInstance::HiddenInput
  #include ::Magnets::HTML::Form::ClassInstance::MonthInput
  #include ::Magnets::HTML::Form::ClassInstance::NumberInput
  #include ::Magnets::HTML::Form::ClassInstance::PasswordInput
  #include ::Magnets::HTML::Form::ClassInstance::RadioInput
  #include ::Magnets::HTML::Form::ClassInstance::RangeInput
  #include ::Magnets::HTML::Form::ClassInstance::SearchInput
  #include ::Magnets::HTML::Form::ClassInstance::SelectInput
  #include ::Magnets::HTML::Form::ClassInstance::TelephoneInput
  #include ::Magnets::HTML::Form::ClassInstance::TextInput
  #include ::Magnets::HTML::Form::ClassInstance::TextInput::TextAreaInput
  #include ::Magnets::HTML::Form::ClassInstance::TextInput
  #include ::Magnets::HTML::Form::ClassInstance::URLInput
  #include ::Magnets::HTML::Form::ClassInstance::WeekInput

  include ::Magnets::HTML::Form::ClassInstance::ValidationDefinition

	######################################  Configuration  ###########################################

  ###############################
  #  __data_validation_class__  #
  ###############################

  def __data_validation_class__
    
    return @__data_validation_class__ ||= ::Magnets::HTML::Form::
                                            DataValidationObject.new_validated_object_class( self )
    
  end

	###################################  Runtime Verification  #######################################  

  ####################
  #  __has_input__?  #
  ####################

  def __has_input__?
    
    return true
    
  end

  #############################
  #  __process_form_values__  #
  #############################

  def __process_form_values__( data_validation_object )
    
    validates = false
    
    # validate inputs, then call form-level validation procs
    if validates = __validate_form_values__( data_validation_object )
      
      __call_success_procs__( data_validation_object )
      
    else

      __call_failure_procs__( data_validation_object )
      
    end

    return validates
    
  end

  ##############################
  #  __validate_form_values__  #
  ##############################

  def __validate_form_values__( data_validation_object )

    validates = true

		# For each form input binding, verify form value.
		# We go from binding configurations to form value instead of starting with form value
		# to prevent arbitrary form data from determining program action.
		__input_bindings__.each do |this_binding_name, this_binding_instance|

      this_form_value_or_nested_values = data_validation_object.__send__( this_binding_name )
		  
		  case view_class = this_binding_instance.__view_class__
		    
  	    when ::Magnets::HTML::Form::Input::ClassInstance
	        
  	      unless this_binding_instance.__validate_form_value__( this_form_value_or_nested_values )
  	        validates = false
  	      end
  	      
  	    when ::Magnets::HTML::Form
	        
	        # tell the binding to validate form values for all of its inputs
  	      unless this_binding_instance.__process_form_values__( this_form_value_or_nested_values )
		        validates = false
		      end
		      
		    else
		      
		      if view_class.__has_input__?
		        unless view_class.__validate_form_values__( this_form_value_or_nested_values )
		          validates = false
	          end
	        end
		      
	    end
		  
	  end
	  
	  if validates
	    validates = __call_validation_procs__( data_validation_object )
    end
	  
	  return validates
		
	end

  ###############################
  #  __call_validation_procs__  #
  ###############################

  def __call_validation_procs__( data_validation_object )

    validates = false

		__validation_procs__.each do |this_validation_proc|
		  break unless validates = this_validation_proc.call( data_validation_object )
    end
    
    return validates

  end

  ############################
  #  __call_success_procs__  #
  ############################

  def __call_success_procs__( data_validation_object )

    __success_procs__.each do |this_success_proc|
      this_success_proc.call( data_validation_object )
    end

  end
  
  ############################
  #  __call_failure_procs__  #
  ############################
  
  def __call_failure_procs__( data_validation_object )

    __failure_procs__.each do |this_failure_proc|
      this_failure_proc.call( data_validation_object )
    end
    
  end
  
end
