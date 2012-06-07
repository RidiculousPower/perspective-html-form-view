
module ::Magnets::HTML::Form::ClassInstance

  ##################
  #  attr_subform  #
  ##################
  
  def attr_subform( *args, & configuration_proc )
    
    bindings = attr_view( *args, & configuration_proc )
    
    bindings.each do |this_binding|
      this_binding.extend( ::Magnets::HTML::Form::Binding )
      this_binding.__form_permitted__ = true
      this_binding_name = this_binding.__name__
      __bindings_with_forms__[ this_binding_name ] = this_binding
      self::DataValidationClass.define_subview( this_binding_name )
    end
    
    return bindings
    
  end
  
end
