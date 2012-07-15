
module ::Magnets::HTML::Form::Bindings::ClassBinding::NestedClassBinding

  ################
  #  initialize  #
  ################

  def initialize( bound_container, 
                  binding_name,
                  container_class = nil, 
                  ancestor_binding = nil,
                  & configuration_proc )
    
    super
    
    __initialize_for_parent_binding__
        
  end

  #######################################
  #  __initialize_for_parent_binding__  #
  #######################################
  
  def __initialize_for_parent_binding__

    this_parent_binding = self
    
    this_last_parent = this_parent_binding
    
    while this_parent_binding = this_parent_binding.__bound_container__

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
