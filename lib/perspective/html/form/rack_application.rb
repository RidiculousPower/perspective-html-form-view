
module ::Perspective::HTML::Form::RackApplication
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
	#######################
  #  initialize_status  #
  #######################
  
  def initialize_status
        
    # if we have POST or PUT with our hidden input route field, process form results
    if ( @request.post? or @request.get? )                                                   and 
       form_route_key = ::Perspective::HTML::Form.__hidden_input_for_form_route_input_name__ and
       form_route_string = @request.raw_parameters.delete( form_route_key )
      
      form_route = form_route_string.split( ::Perspective::Bindings::RouteDelimiter )
      root_text = form_route.shift
      binding_name = form_route.pop
      
      process_form_values( form_route, binding_name )
    
    else
      
      super
      
    end
        
  end

  ####################
  #  render_content  #
  ####################
  
  def render_content
  
  	case @status
	    
      when 200

  	    super

    end
    
    return @content
    
  end
  
  #########################
  #  process_form_values  #
  #########################
	
  def process_form_values( form_route, binding_name )
    
    form_root_binding = ::Perspective::HTML::Form.form_binding_in_context( @root_instance,
                                                                           form_route, 
                                                                           binding_name )
    
    form_instance = form_class.new
       
    form_instance.__initialize_from_form_parameters__
     
    # redirect based on success/failure
    if form_instance.validates?

    else
      
    end
    
  end
  
end
