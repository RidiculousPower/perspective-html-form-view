
module ::Magnets::HTML::Form::Bindings::ClassBinding

  include ::Magnets::HTML::Form::Configuration

  ################
  #  initialize  #
  ################

  def initialize( bound_container, 
                  binding_name,
                  container_class = nil, 
                  ancestor_binding = nil,
                  & configuration_proc )
    
    super
    
    __initialize_for_bound_form__
        
  end
  
  ###################################
  #  __initialize_for_bound_form__  #
  ###################################
  
  def __initialize_for_bound_form__
    
    case __container_class__

      when ::Magnets::HTML::Form::ClassInstance

        @__bound_container__.__form_bindings__.push( self )

      when ::Magnets::HTML::Form::Input::ClassInstance

        @__bound_container__.__input_bindings__.push( self )

    end
    
  end
    
end
