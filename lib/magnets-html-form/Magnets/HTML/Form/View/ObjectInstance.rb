
module ::Magnets::HTML::Form::View::ObjectInstance

  include ::CascadingConfiguration::Hash
  
  #############################
  #  __bindings_with_forms__  #
  #############################

  attr_configuration_hash  :__bindings_with_forms__ do
    
    #======================#
	  #  child_pre_set_hook  #
	  #======================#
	  
	  def child_pre_set_hook( binding_name, binding_instance )

      return __bindings__[ binding_name ]
      
    end
	  
  end

end
