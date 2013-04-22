# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::Context

	#############################
  #  form_binding_in_context  #
  #############################
  
  def form_binding_in_context( binding_context, binding_route, binding_name )
        
    form_binding = ::Perspective::Bindings.binding_in_context( binding_context, binding_route, binding_name )
    
    unless form_binding.respond_to?( :«form_class» ) and 
           ::Perspective::HTML::Form::SingletonInstance === form_binding.«form_class»
      raise ::Perspective::Bindings::Exception::FormBindingExpected.new( form_binding )
    end
    
    return form_binding
    
  end

end
