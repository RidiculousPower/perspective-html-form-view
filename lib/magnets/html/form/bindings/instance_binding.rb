
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

  ##################
  #  to_html_node  #
  ##################

  def to_html_node( document_frame = nil, view_rendering_empty = false )

    self_as_html_node = super

    unless nested?
      
      hidden_binding_name = ::Magnets::HTML::Form.__hidden_input_for_form_route_binding_name__
      hidden_binding_instance = __bindings__[ hidden_binding_name ]
      
      hidden_binding_node = hidden_binding_instance.to_html_node( document_frame, 
                                                                  view_rendering_empty )
      
      self_as_html_node.add_child( hidden_binding_node )
      
    end
    
    return self_as_html_node
    
  end
  
end
