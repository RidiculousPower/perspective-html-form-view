
class ::Magnets::HTML::Form::DataValidationObject

  #####################################
  #  self.new_validated_object_class  #
  #####################################
  
  def self.new_validated_object_class( view_or_form_class )
    
    new_data_validation_object_class = ::Class.new( self ) do
      @subviews = { }
      @view_class = view_or_form_class
    end
    
    view_or_form_class.const_set( :DataValidationObject, new_data_validation_object_class )
        
    return new_data_validation_object_class
    
  end

  #####################
  #  self.view_class  #
  #####################
  
  def self.view_class
    
    return @view_class
    
  end

  ###################
  #  self.subviews  #
  ###################
  
  def self.subviews
    
    return @subviews
    
  end
  
  #######################
  #  self.define_input  #
  #######################
  
  def self.define_input( input_binding_name )
    
    variable_name = input_binding_name.variable_name
    
    #======================#
    #  input_binding_name  #
    #======================#
    
    define_method( input_binding_name ) do

      return instance_variable_get( variable_name )
      
    end

    #=======================#
    #  input_binding_name=  #
    #=======================#

    define_method( input_binding_name.write_accessor_name ) do |value|
      
      instance_variable_set( variable_name, value )
      
    end
    
  end

  ##########################
  #  self.define_subview  #
  ##########################
  
  def self.define_subview( subview_binding_name )

    variable_name = subview_binding_name.variable_name

    # get the binding configuration
    binding_instance = view_class.__binding__( subview_binding_name )
    validated_data_class = binding_instance.__view_class__.__data_validation_class__

    @subviews[ subview_binding_name ] = validated_data_class
    
    #========================#
    #  subview_binding_name  #
    #========================#
    
    define_method( subview_binding_name ) do

      return instance_variable_get( variable_name )
      
    end

  end
  
  ################
  #  initialize  #
  ################
  
  def initialize
    
    view_class = self.class.view_class
    
    self.class.subviews.each do |this_subview_binding_name, this_validated_data_class|

      # instantiate DataValidationObject for view class
      this_subview_data_object = this_validated_data_class.new
      instance_variable_set( this_subview_binding_name.variable_name, this_subview_data_object )

    end
    
  end
  
  #########################
  #  __failed_bindings__  #
  #########################
  
  def __failed_bindings__
    
  end
  
end
