# -*- encoding : utf-8 -*-

module ::Perspective::BindingTypes::HTMLFormViewBindings::ClassBinding

  include ::Perspective::HTML::Form::View::Configuration

  #################################
  #  initialize«common_finalize»  #
  #################################

  def initialize«common_finalize»

    super

    initialize«for_bound_container»
  
  end

  ######################################
  #  initialize«for_bound_container»  #
  ######################################
  
  def initialize«for_bound_container»

    # When a nested class binding is created it needs to check parent bound containers
    # to determine whether binding is nested inside a form.
    #
    #   F-V-...-NF => F needs to know about NF in V
    #
    # Form Bindings are only created for forms and subforms.
    #
    
    # Find the first parent form instance if there is one.

    this_parent_container = self
    
    while this_parent_container = this_parent_container.«bound_container»

      case this_parent_container
        
        # We get to a form class instance if the form is the root,
        # or to a form binding if form is bound to another view.
        when ::Perspective::HTML::Form::SingletonInstance, 
             ::Perspective::Bindings::BindingTypeContainer::HTMLForm::View::ClassBinding

           # binding needs nested support
          nested!
          this_parent_container.«subform_bindings».push( self )
          @«parent_form_or_form_binding» = this_parent_container
          break

      end

    end

  end

end
