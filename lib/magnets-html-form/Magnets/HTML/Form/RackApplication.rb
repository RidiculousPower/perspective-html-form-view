
module ::Magnets::HTML::Form::RackApplication
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
	#######################
  #  initialize_status  #
  #######################
  
  def initialize_status
        
    # if we have POST or PUT with FormProcessingURLBase, process form results
    if ( @request.post? or @request.put? ) and 
       @request.path.current_part == ::Magnets::HTML::Form::FormProcessingURLBase
      
      # we matched ::Magnets::HTML::Form::FormProcessingURLBase
      @request.path.matched_part!
      
      process_form_values
    
    else
      
      super
      
    end
        
  end

  ####################
  #  render_content  #
  ####################
  
  def render_content
  
  	if @status == 200
	    super
    end
    
    return @content
    
  end
  
  #########################
  #  process_form_values  #
  #########################
	
  def process_form_values
    
    form_root = form_context
    
    @request.initialize_parameters( form_root )
    
    # redirect based on success/failure
    if form_root.__process_form_values__( @request.parameters )

    else
      
    end
    
  end
  
  ##################
  #  form_context  #
  ##################
  
  def form_context
    
    binding_route = @request.path.remaining_parts.dup
    
    form_binding_name = binding_route.pop
    
    # we need to get the shared binding context from our root 
    form_binding_context = ::Magnets::Bindings::Container.context( form_binding_name, 
                                                                   @root_instance, 
                                                                   binding_route,
                                                                   form_binding_name )
    
    form_class = form_binding_context.__binding__( form_binding_name ).__view_class__
    
    unless form_class.is_a?( ::Magnets::HTML::Form::ClassInstance )
      raise ::RuntimeError, 'Expected form binding at :' + form_binding_name + 
            ' in context :' + binding_route.join( '.' ) +
    	      ' (' + form_binding_context.inspect + ') does not refer to a form view class. (' +
    	      form_binding.inspect + ')'
    end
    
    return form_class
    
  end

end
