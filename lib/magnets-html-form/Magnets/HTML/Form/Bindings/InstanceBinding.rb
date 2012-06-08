
module ::Magnets::HTML::Form::Bindings::InstanceBinding

  include ::Magnets::HTML::Form::Configuration

  ######################
  #  value_validates?  #
  ######################

  def value_validates?( binding_value = @__value__ )
    
    validates = false
    
    if binding_value_valid?( binding_value )
      validates = validation_procs_validate_value?
    end
    
    return validates
    
  end

  ######################################
  #  validation_procs_validate_value?  #
  ######################################

  def validation_procs_validate_value?( binding_value = @__value__ )

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
