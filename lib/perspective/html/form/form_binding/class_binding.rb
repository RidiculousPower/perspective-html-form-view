
module ::Perspective::HTML::Form::FormBinding::ClassBinding

  include ::Perspective::HTML::Form::Configuration

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

    # When a nested class binding is created it needs to check parent bound containers
    # to determine whether binding is nested inside a form.
    #
    #   F-V-...-NF => F needs to know about NF in V
    #
    # Form Bindings are only created for forms and subforms.
    #
    
    # Find the first parent form instance if there is one.

    this_parent_container = self
    
    while this_parent_container = this_parent_container.__bound_container__

      case this_parent_container
        
        # We get to a form class instance if the form is the root,
        # or to a form binding if form is bound to another view.
        when ::Perspective::HTML::Form::ClassInstance, 
             ::Perspective::Bindings::AttributeContainer::HTMLForm::ClassBinding

           # binding needs nested support
          nested!
          this_parent_container.__subform_bindings__.push( self )
          @__parent_form_or_form_binding__ = this_parent_container
          break

      end

    end

  end

end
