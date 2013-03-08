# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::Context

	#############################
  #  form_binding_in_context  #
  #############################
  
  def form_binding_in_context( binding_context, binding_route, binding_name )
        
    # we need to get the shared binding context from our root 
    form_binding = ::Perspective::Bindings.binding_in_context( binding_context, 
                                                               binding_route,
                                                               binding_name )
    
    case form_class = form_root_binding.«form_class»
      when ::Perspective::HTML::Form::SingletonInstance
      else
        raise ::Perspective::Bindings::Exception::FormBindingExpected.new( form_binding )
    end
    
    return form_binding
    
  end

end
