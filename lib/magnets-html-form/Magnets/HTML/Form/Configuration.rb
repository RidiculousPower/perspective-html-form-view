
module ::Magnets::HTML::Form::Configuration

  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array::Unique

  ccm = ::CascadingConfiguration::Methods

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

  attr_module_configuration_unique_array  :__validation_procs__

  ccm.alias_module_method( self, :validation_procs, :__validation_procs__ )

  #######################
  #  __success_procs__  #
  #######################

  attr_module_configuration_unique_array  :__success_procs__

  ccm.alias_module_method( self, :success_procs, :__success_procs__ )
  
  #######################
  #  __failure_procs__  #
  #######################

  attr_module_configuration_unique_array  :__failure_procs__

  ccm.alias_module_method( self, :failure_procs, :__failure_procs__ )

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

    data_validation_object.inputs.each do |this_input_binding_name, this_input_binding_instance|
      
      unless this_input_binding_instance.__validate_form_values__( data_validation_object )
        validates = false
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

  ################################
  #  rendering_inside_form?      #
  #  __rendering_inside_form__=  #
  ################################

  attr_module_configuration :rendering_inside_form? => :__rendering_inside_form__=
  
  self.__rendering_inside_form__ = false
  
  ############################
  #  rendering_inside_form!  #
  ############################

  def rendering_inside_form!

    self.__rendering_inside_form__ = true

  end

end
