
module ::Magnets::HTML::Form::BindingContext

	##################################
  #  self.form_binding_in_context  #
  ##################################
  
  def self.form_binding_in_context( binding_context, binding_route, binding_name )
        
    # we need to get the shared binding context from our root 
    form_binding = ::Magnets::Bindings.binding_in_context( binding_context, 
                                                           binding_route,
                                                           binding_name )
    
    case form_class = form_root_binding.__form_class__
      when ::Magnets::HTML::Form::ClassInstance
      else
        raise ::Magnets::Bindings::Exception::FormBindingExpected.new( form_binding )
    end
    
    return form_binding
    
  end

end
