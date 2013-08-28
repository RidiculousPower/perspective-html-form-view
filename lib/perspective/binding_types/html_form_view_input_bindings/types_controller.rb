# -*- encoding : utf-8 -*-

class ::Perspective::BindingTypes::HTMLFormViewInputBindings::TypesController
  
  ##############################
  #  self.new«class_bindings»  #
  ##############################
  
  ###
  # Create a new class binding for each binding name, each having the same configuration block. 
  #
  # 
  #
  def self.new«class_bindings»( binding_type, bound_to_container, *binding_names, & configuration_proc )

    bindings = binding_names.collect do |this_binding_name|
      binding_type.class_binding_class.new( bound_to_container, this_binding_name, & configuration_proc )
    end
    
    return bindings
    
  end

  ###############################
  #  self.enable_class_binding  #
  ###############################
  
  ###
  # 
  #
  def self.enable_class_binding( bound_to_container, binding_instance )
    
    super
    
    bound_to_container.«input_bindings».push( binding_instance )
    
    return binding_instance
    
  end
  
end
