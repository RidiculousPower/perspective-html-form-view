
module ::Perspective::HTML::Form::Configuration
  
  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array::Unique

  #################
  #  nested?      #
  #  __nested__=  #
  #################

  attr_configuration :nested? => :__nested__=
  
  self.__nested__ = false
  
  #############
  #  nested!  #
  #############

  def nested!

    self.__nested__ = true

  end

  ########################
  #  input_bindings      #
  #  __input_bindings__  #
  ########################

  attr_unique_array  :__input_bindings__ do
    
    #======================#
	  #  child_pre_set_hook  #
	  #======================#

	  def child_pre_set_hook( index, binding_instance, is_insert, parent_hash )

	    return configuration_instance.__binding__( binding_instance.__name__ )
	    
	  end
	  
  end

  Controller.alias_module_and_instance_methods( :input_bindings, :__input_bindings__ )

  ##########################
  #  subform_bindings      #
  #  __subform_bindings__  #
  ##########################
  
  attr_unique_array  :__subform_bindings__ do

    #======================#
	  #  child_pre_set_hook  #
	  #======================#

	  def child_pre_set_hook( index, binding_instance, is_insert, parent_hash )

	    return configuration_instance.__binding__( binding_instance.__name__ )
	    
	  end
    
  end

  Controller.alias_module_and_instance_methods( :subform_bindings, :__subform_bindings__ )

  ##################
  #  validate      #
  #  __validate__  #
  ##################
  
  def __validate__( & validation_proc )
  
    __validation_procs__.push( validation_proc )
    
  end

  alias_method :validate, :__validate__

  #################
  #  failure      #
  #  __failure__  #
  #################

  def __failure__( & failure_proc )

    __failure_procs__.push( failure_proc )

  end

  alias_method :failure, :__failure__
  
  #################
  #  success      #
  #  __success__  #
  #################

  def __success__( & success_proc )

    __success_procs__.push( success_proc )

  end

  alias_method :success, :__success__

  ##########################
  #  __validation_procs__  #
  ##########################

  attr_unique_array  :__validation_procs__

  Controller.alias_module_and_instance_methods( :validation_procs, :__validation_procs__ )

  #######################
  #  __success_procs__  #
  #######################

  attr_unique_array  :__success_procs__

  Controller.alias_module_and_instance_methods( :success_procs, :__success_procs__ )
  
  #######################
  #  __failure_procs__  #
  #######################

  attr_unique_array  :__failure_procs__

  Controller.alias_module_and_instance_methods( :failure_procs, :__failure_procs__ )

  #############################
  #  __process_form_values__  #
  #############################

  def __process_form_values__
    
    validates = false
    
    # validate inputs, then call form-level validation procs
    if validates = __validate_form_values__
      
      __call_success_procs__
      
    else

      __call_failure_procs__
      
    end

    return validates
    
  end

end
