
module ::Magnets::HTML::Form::Bindings::ClassBinding

  include ::Magnets::HTML::Form::Configuration

  ################
  #  initialize  #
  ################

  def initialize( bound_container, 
                  binding_name,
                  container_class = nil, 
                  ancestor_binding = nil,
                  base_route = nil, 
                  & configuration_proc )
    
    super
    
    case bound_container
      
      when ::Magnets::HTML::Form::ClassInstance
        
        __initialize_for_parent_form__
            
      when ::Magnets::Bindings::AttributeContainer::HTMLForm::ClassBinding
      
        __initialize_for_parent_binding__
        
    end
    
  end
  
  ####################################
  #  __initialize_for_parent_form__  #
  ####################################
  
  def __initialize_for_parent_form__
    
    case __container_class__

      when ::Magnets::HTML::Form::ClassInstance

        @__bound_container__.__form_bindings__.push( self )

      when ::Magnets::HTML::Form::Input::ClassInstance

        @__bound_container__.__input_bindings__.push( self )

    end
    
    # If we are a non-nested form and happened to use the same binding name as the hidden form
    # input used to store the form route for processing then we need to change the name used
    # for the input to the alternate (which is uglier but almost certain not to be used).
    if __name__ == ::Magnets::HTML::Form.__hidden_input_for_form_route_input_name__
      hidden_binding_name = ::Magnets::HTML::Form.__hidden_input_for_form_route_binding_name__
      @__bound_container__.__binding__( hidden_binding_name ).configure do |hidden_binding_instance|
        alternate_name = ::Magnets::HTML::Form.__alternate_hidden_input_for_form_route_name__
        hidden_binding_instance.name = alternate_name
      end
    end
    
  end

  #######################################
  #  __initialize_for_parent_binding__  #
  #######################################
  
  def __initialize_for_parent_binding__

    this_parent_binding = self
    
    this_last_parent = this_parent_binding
    
    while this_parent_binding = this_parent_binding.__parent_binding__

      case this_parent_binding

        when ::Magnets::Bindings::AttributeContainer::HTMLForm::ClassBinding
          
          nested!
          this_parent_binding.__form_bindings__.push( self )
          @__parent_form_or_form_binding__ = this_parent_binding
          break

      end

      this_last_parent = this_parent_binding

    end
    
    unless nested?

      case container_class = this_last_parent.__bound_container_class__

        when ::Magnets::HTML::Form::ClassInstance
          
          nested!
          container_class.__form_bindings__.push( self )
          @__parent_form_or_form_binding__ = container_class              

      end

    end

  end
  
end
