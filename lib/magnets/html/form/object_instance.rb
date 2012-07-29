
module ::Magnets::HTML::Form::ObjectInstance
  
  include ::Magnets::HTML::View::ObjectInstance
  
  include ::Magnets::HTML::Form::Configuration

  include ::CascadingConfiguration::Setting

	# Unlike other containers, in this case we actually need to be a Form to start.
	# This is because we expect all forms to have a hidden input with the form processing path.
	extend ::Magnets::HTML::Form::ClassInstance
  
  ####################################################
  #  __hidden_input_for_form_route_input_name__      #
  #  __alternate_hidden_input_for_form_route_name__  #
  #  __hidden_input_for_form_route_binding_name__    #
  ####################################################

  # We need to be able to identify the form binding route from other form inputs.
	# Since we want to be able to redraw the form without first reloading a url we don't want
	# to change the URL as a way of passing the form binding route. Instead, we pass the route
	# as a hidden input.
	#
	# We want the name to be unique and preferably short, since it will appear in GET strings.
	# 
	attr_module_configuration  :__hidden_input_for_form_route_input_name__, 
	                           :__hidden_input_for_form_route_binding_name__

  # MFR for "Magnets Form Route"
  self.__hidden_input_for_form_route_input_name__   = '*MFR*'
  self.__hidden_input_for_form_route_binding_name__ = __hidden_input_for_form_route_input_name__.to_sym
  
  ###############################
  #  subform_container_tag      #
  #  __subform_container_tag__  #
  ###############################

	attr_configuration  :__subform_container_tag__

  Controller.alias_module_and_instance_methods( :subform_container_tag, :__subform_container_tag__ )

  self.__container_tag__ = :form
  self.__subform_container_tag__ = :div
  
  #########################################
	#  __initialize_from_form_parameters__  #
  #########################################
	
  def __initialize_from_form_parameters__
        
    # we have 'path-to-binding' => value
    # we want to turn it into path.to.binding = value
    ::Magnets::Request.raw_parameters.each do |this_parameter_route_name, this_parameter_value|
      
      # The current data validation context.
      this_context = self
      
      # The post/put name we are splitting into nested hash values.
      this_route_remainder = this_parameter_route_name

      # We need a break variable to double-break from our inner loop.
      badly_formed_route = false

      while this_index = this_route_remainder.index( ::Magnets::Bindings::RouteDelimiter )
        
        # slice off route part
        this_route_part = this_route_remainder.slice( 0, this_index )

        # keep remainder
        this_remainder_length = this_route_remainder.length - this_index - 1
        this_route_remainder = this_route_remainder.slice( this_index + 1, this_remainder_length )

        # if we got badly formed parameter route name, skip to the next parameter
        unless this_context = this_context.__binding__( this_route_part )
          badly_formed_route = true
          break
        end
        
      end
      
      # If we got badly formed parameter input name, skip to the next parameter.
      # 
      # We don't want to allow someone to break the route and try the next route part
      # as an input on the broken element.
      # For instance if we have /path/to/route and "to" is a badly formed route, "route"
      # could end up getting called on "path" as an assignment value.
      #
      if badly_formed_route
        badly_formed_route = false
        next
      end
        
      # last remaining part is binding name for input corresponding to value
      this_input_name = this_route_remainder

      if this_input_binding_instance = this_context.__binding__( this_input_name )
        this_input_binding_instance.__value__ = this_parameter_value
      end
      
    end
    
    return self
    
  end

  ################
  #  validates?  #
  ################

  def validates?
    
    validates = false
    
    if validates = inputs_validate?
      validates = validation_procs_validate?
    end
    
    return validates
    
  end
  
  ######################
  #  inputs_validate?  #
  ######################

  def inputs_validate?
    
    validates = true
    
    __input_bindings__.each do |this_input_binding|
      unless this_input_binding.value_validates?
        validates = false
      end
    end
    
    return validates
    
  end
  
  ################################
  #  validation_procs_validate?  #
  ################################

  def validation_procs_validate?

    validates = false

		__validation_procs__.each do |this_validation_proc|
		  break unless validates = instance_exec( & this_validation_proc )
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
