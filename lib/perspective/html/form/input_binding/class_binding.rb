
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

    __bound_container__.__input_bindings__.push( self )
        
  end
  
end
