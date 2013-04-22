# -*- encoding : utf-8 -*-

module ::Perspective::BindingTypes::HTMLFormViewInputBindings::TypesController
  
  #############################
  #  self.new_class_bindings  #
  #############################
  
  ###
  # Create a new class binding for each binding name, each having the same configuration block. 
  #
  # 
  #
  def self.new_class_bindings( binding_type, bound_to_container, *binding_names, & configuration_proc )

    bindings = binding_names.collect do |this_binding_name|
      binding_type.class_binding_class.new( bound_to_container, this_binding_name, & configuration_proc )
    end
    
    «bound_container».«input_bindings».concat( bindings )
    
    return bindings
    
  end
  
end
