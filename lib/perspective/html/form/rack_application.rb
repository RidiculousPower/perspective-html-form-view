# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::RackApplication
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
  ####################
  #  render_content  #
  ####################
	
  def render_content

    # if we have POST or PUT with our hidden input route field, process form results
    if @request.post? || @request.get?                                                         and 
       form_route_key = ::Perspective::HTML::Form.«input_name_for_hidden_input_for_form_route» and
       form_route_string = @request.raw_parameters.delete( form_route_key )

      process_form_values( form_route_string )
      
    end

  	super if @status.equal?( 200 )

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
      form_instance = ::Perspective::HTML::Form.form_binding_in_context( root_instance, form_route, binding_name )
    else
      form_instance = root_instance
    end
    
    form_instance.«initialize_from_form_parameters»
     
    # redirect based on success/failure
    if form_instance.validates?

    else
      
    end
    
    return form_instance
    
  end
  
end
