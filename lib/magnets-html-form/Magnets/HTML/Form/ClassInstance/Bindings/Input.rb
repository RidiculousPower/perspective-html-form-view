
module ::Magnets::HTML::Form::ClassInstance

  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
  #####################
  #  attr_input_view  #
  #####################
  
  def attr_input_view( *args, & configuration_proc )
    
    bindings = attr_view( *args, & configuration_proc )
    
    bindings.each do |this_binding|
      this_binding_name = this_binding.__name__
      __input_bindings__[ this_binding_name ] = this_binding
      self::DataValidationClass.define_input( this_binding_name )
      # insert configuration proc to name input before label and error ask for name
      input_configuration_proc = Proc.new do |input_instance|
        input_instance.name = this_binding.__route_string__
      end
      this_binding.__configuration_procs__.unshift( input_configuration_proc )
    end
    
    return bindings
    
  end
  
end
