
module ::Perspective::HTML::Form::Bindings::ClassBinding::NestedClassBinding

  ################
  #  initialize  #
  ################

  def initialize( bound_container, 
                  binding_name,
                  container_class = nil, 
                  ancestor_binding = nil,
                  & configuration_proc )
    
    super
    
    __initialize_for_bound_container__
        
  end

  ########################################
  #  __initialize_for_bound_container__  #
  ########################################
  
  def __initialize_for_bound_container__

    # When a nested form class binding is created it needs to tell each parent container until the next
    # parent form that the binding in question has a nested form:
    #
    #   F-V-...-NF => F needs to know about NF in V
    #
    # Form Bindings are only created for forms and form inputs.
    #
    
    
    # Find the first parent form instance.


    this_last_parent = this_parent_container = self
    
    while this_parent_container = this_parent_container.__bound_container__

      case this_parent_container

        when ::Perspective::Bindings::AttributeContainer::HTMLForm::ClassBinding
          
          nested!
          this_parent_binding.__form_bindings__.push( self )
          @__parent_form_or_form_binding__ = this_parent_binding
          break

      end

      this_last_parent = this_parent_binding

    end
    
    # 
    unless nested?

      case container_class = this_last_parent.__bound_container_class__

        when ::Perspective::HTML::Form::ClassInstance
          
          nested!
          container_class.__form_bindings__.push( self )
          @__parent_form_or_form_binding__ = container_class              

      end

    end

  end

end
