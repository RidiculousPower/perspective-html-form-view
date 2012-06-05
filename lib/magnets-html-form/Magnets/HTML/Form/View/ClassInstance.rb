
module ::Magnets::HTML::Form::View::ClassInstance

  include ::Magnets::HTML::Form::ClassInstance
  include ::Magnets::HTML::Form::ClassInstance

  ###############################
  #  __data_validation_class__  #
  ###############################

  def __data_validation_class__
    
    return @__data_validation_class__ ||= ::Magnets::HTML::Form::
                                            DataValidationObject.new_validated_object_class( self )
    
  end
  
  ####################
  #  __has_input__?  #
  ####################

  def __has_input__?
    
    return ! __bindings_with_forms__.empty?
    
  end

  ##############################
  #  __validate_form_values__  #
  ##############################
  
  def __validate_form_values__( data_validation_object )
    
    validates = true
    
    __bindings_with_forms__.each do |this_binding_name, this_binding_instance|
      
      sub_data_validation_object = data_validation_object.__send__( this_binding_name )
      unless this_binding_instance.__process_form_values__( sub_data_validation_object )
        validates = false
      end

    end
    
    return validates
	  
  end
  alias_method :__process_form_values__, :__validate_form_values__
    
end
