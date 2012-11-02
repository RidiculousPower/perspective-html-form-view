
module ::Perspective::HTML::Form::RackApplication
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
  ####################
  #  render_content  #
  ####################
	
  def render_content

    # if we have POST or PUT with our hidden input route field, process form results
    if @request.post? || @request.get?                                                       and 
       form_route_key = ::Perspective::HTML::Form.__hidden_input_for_form_route_input_name__ and
       form_route_string = @request.raw_parameters.delete( form_route_key )

      process_form_values( form_route_string )
      
    end

  	case @status
	    
      when 200

  	    super

    end
    
    return @content
        
  end

  #########################
  #  process_form_values  #
  #########################
	
  def process_form_values( form_route_string )
    
    form_instance = nil
    
    form_route = form_route_string.split( ::Perspective::Bindings::RouteDelimiter )
    binding_name = form_route.pop

    # it is possible that we have no form route
    # if we have no form route it is also possible we have no binding name
    
    # if we have neither form route nor binding name then a form was set as the root container
    
    if binding_name
      form_instance = ::Perspective::HTML::Form.form_binding_in_context( root_instance,
                                                                         form_route, 
                                                                         binding_name )
    else
      form_instance = root_instance
    end
    
    
    form_instance.__initialize_from_form_parameters__
     
    # redirect based on success/failure
    if form_instance.validates?

    else
      
    end
    
    return form_instance
    
  end
  
end
