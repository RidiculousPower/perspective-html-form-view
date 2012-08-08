
module ::Perspective::HTML::Form::Configuration
  
  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array::Unique

  #######################
  #  form_bindings      #
  #  __form_bindings__  #
  #######################

  attr_unique_array  :__form_bindings__ do
    
    #======================#
	  #  child_pre_set_hook  #
	  #======================#

	  def child_pre_set_hook( index, binding_instance, is_insert )
      
      nested_route = configuration_instance.__nested_route__( binding_instance )
      
      if nested_route

        child_instance = ::Perspective::HTML::Form.form_binding_in_context( configuration_instance, 
                                                                        nested_route,
                                                                        binding_instance.__name__ )
        
      else
      
        child_instance = configuration_instance.__binding__( binding_instance.__name__ )

      end
      
	    return child_instance
	    
	  end
	  
  end

  Controller.alias_module_and_instance_methods( :form_bindings, :__form_bindings__ )

  ########################
  #  input_bindings      #
  #  __input_bindings__  #
  ########################

  attr_unique_array  :__input_bindings__ do
    
    #================#
	  #  pre_set_hook  #
	  #================#

	  #def pre_set_hook( index, binding_instance, is_insert )
    #  
    #  child_instance = nil
    #  
    #  case instance = configuration_instance
    #    
    #    when ::Perspective::HTML::Form::ClassInstance
    #      
    #      
    #      
    #    when ::Perspective::HTML::Form::ObjectInstance
    #
    #    when ::Perspective::Bindings::AttributeContainer::HTMLForm::ClassBinding
    #
    #    when ::Perspective::Bindings::AttributeContainer::HTMLForm::InstanceBinding
    #    
    #  end
    #  
    #  return child_instance
    #  
    #end
    
    #======================#
	  #  child_pre_set_hook  #
	  #======================#

	  def child_pre_set_hook( index, binding_instance, is_insert )

	    return configuration_instance.__binding__( binding_instance.__name__ )
	    
	  end
	  
  end

  Controller.alias_module_and_instance_methods( :input_bindings, :__input_bindings__ )

  ##############
  #  validate  #
  ##############
  
  def validate( & validation_proc )
  
    __validation_procs__.push( validation_proc )
    
  end

  #############
  #  failure  #
  #############

  def failure( & failure_proc )

    __failure_procs__.push( failure_proc )

  end
  
  #############
  #  success  #
  #############

  def success( & success_proc )

    __success_procs__.push( success_proc )

  end

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
