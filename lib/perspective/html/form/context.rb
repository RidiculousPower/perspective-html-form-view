
module ::Perspective::HTML::Form::Context

	#############################
  #  form_binding_in_context  #
  #############################
  
  def form_binding_in_context( binding_context, binding_route, binding_name )
        
    # we need to get the shared binding context from our root 
    form_binding = ::Perspective::Bindings.binding_in_context( binding_context, 
                                                               binding_route,
                                                               binding_name )
    
    case form_class = form_root_binding.__form_class__
      when ::Perspective::HTML::Form::ClassInstance
      else
        raise ::Perspective::Bindings::Exception::FormBindingExpected.new( form_binding )
    end
    
    return form_binding
    
  end

end
