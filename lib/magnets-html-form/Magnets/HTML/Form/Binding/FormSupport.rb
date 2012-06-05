
module ::Magnets::HTML::Form::Binding::FormSupport
  
  include ::CascadingConfiguration::Setting
  
  ###################################
  #  __initialize_default_values__  #
  ###################################
  
  def __initialize_default_values__
    
    super
    
    self.__form_permitted__ = false
    
  end

  ################################
  #  __rendering_inside_form__=  #
  ################################

  def __rendering_inside_form__=( true_or_false )

    @__rendering_inside_form__ = true_or_false

  end

  ############################
  #  rendering_inside_form!  #
  ############################

  def rendering_inside_form!

    @__rendering_inside_form__ = true

  end

  ############################
  #  rendering_inside_form?  #
  ############################

  def rendering_inside_form?

    return @__rendering_inside_form__ ||= false

  end

  ##########################
  #  binding_value_valid?  #
  ##########################

  def binding_value_valid?( binding_value )

    case binding_value
      
      when ::Magnets::HTML::Form

        unless form_permitted?
          raise ::Magnets::Bindings::Exception::BindingInstanceInvalidTypeError,
                  'Form given (' + binding_value.inspect.to_s + ') but prohibited by ' +
                  'binding configuration for binding :' + __name__.to_s
        end
        
      else
      
        super
        
    end

  end
  
end
