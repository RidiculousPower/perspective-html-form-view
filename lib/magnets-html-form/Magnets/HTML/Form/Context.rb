
module ::Magnets::HTML::Form::BindingContext

	##########################
  #  self.form_in_context  #
  ##########################
  
  def self.form_in_context( binding_context, binding_route )
        
    form_binding_name = binding_route.pop
    
    # we need to get the shared binding context from our root 
    form_binding = ::Magnets::Bindings.binding_in_context( binding_context, 
                                                           binding_route,
                                                           form_binding_name )
    
    unless form_binding.__form_class__.is_a?( ::Magnets::HTML::Form::ClassInstance )
      raise ::Magnets::Bindings::Exception::FormBindingExpected.new( form_binding )
    end
    
    return form_binding
    
  end

end
