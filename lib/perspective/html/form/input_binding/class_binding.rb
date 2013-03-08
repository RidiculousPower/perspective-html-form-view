# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::InputBinding::ClassBinding

  ################
  #  initialize  #
  ################

  def initialize( bound_container, 
                  binding_name,
                  container_class = nil, 
                  ancestor_binding = nil,
                  & configuration_proc )
    
    super

    «bound_container».«input_bindings».push( self )
        
  end
  
end
