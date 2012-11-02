
module ::Perspective::HTML::Form::InputBinding::InstanceBinding

  include ::Perspective::HTML::Form::Configuration

  ##########################
  #  __value_validates__?  #
  ##########################

  def __value_validates__?( binding_value = @__value__ )
    
    validates = false
    
    if __binding_value_valid__?( binding_value )
      validates = __validation_procs_validate_value__?
    end
    
    return validates
    
  end
  
  ##########################################
  #  __validation_procs_validate_value__?  #
  ##########################################

  def __validation_procs_validate_value__?( binding_value = @__value__ )

    validates = false

		__validation_procs__.each do |this_validation_proc|
		  break unless validates = instance_exec( __input_bindings__, & this_validation_proc )
    end
    
    return validates

  end

  ##############
  #  success!  #
  ##############

  def success!

    __success_procs__.each do |this_success_proc|
      instance_exec( & this_success_proc )
    end

  end
  
  ##############
  #  failure!  #
  ##############
  
  def failure!

    __failure_procs__.each do |this_failure_proc|
      instance_exec( & this_failure_proc )
    end
    
  end

end
