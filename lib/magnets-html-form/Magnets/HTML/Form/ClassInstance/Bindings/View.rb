
module ::Magnets::HTML::Form::ClassInstance
  
  ###############
  #  attr_view  #
  ###############
  
  def attr_view( *args, & configuration_proc )
    
    bindings = super

    # enable attr_form for forms declared as attr_view
    bindings.each do |this_binding|
      case view_class = this_binding.__view_class__
        when ::Magnets::HTML::Form::Input::ClassInstance 
         # nothing to do here
        when ::Magnets::HTML::Form::ClassInstance
          __initialize_view_binding_as_form_binding__( this_binding )
        when ::Magnets::Abstract::View::ClassInstance
          if view_class.__has_input__?
            __initialize_view_binding_as_form_binding__( this_binding )
          end
      end
    end
    
    return bindings
    
  end
  
  #################################################
  #  __initialize_view_binding_as_form_binding__  #
  #################################################
  
  def __initialize_view_binding_as_form_binding__( binding_instance )

    binding_instance.extend( ::Magnets::HTML::Form::Binding )
    binding_instance.__form_permitted__ = true
    binding_instance.rendering_inside_form!
    binding_name = binding_instance.__name__
    __bindings_with_forms__[ binding_name ] = binding_instance
    __data_validation_class__.define_subview( binding_name )
    
  end
  
end
