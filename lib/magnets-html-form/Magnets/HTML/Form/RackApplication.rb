
module ::Magnets::HTML::Form::RackApplication
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
	#######################
  #  initialize_status  #
  #######################
  
  def initialize_status
        
    # if we have POST or PUT with FormProcessingURLBase, process form results
    if ( @request.post? or @request.get? )                                         and 
       form_route_key = ::Magnets::HTML::Form.__hidden_input_name_for_form_route__ and
       form_route = @request.raw_parameters.delete( form_route_key )
      
      process_form_values( form_route )
    
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
	
  def process_form_values( form_route )
        
    form_root_binding = ::Magnets::HTML::Form.form_in_context( @root_instance, form_route )
    
    form_class = form_root_binding.__form_class__
    
    form_instance = form_class.new
    
    form_instance.initialize_form_parameters
    
    # redirect based on success/failure
    if form_root.__process_form_values__( @request.parameters )

    else
      
    end
    
  end
  
end
