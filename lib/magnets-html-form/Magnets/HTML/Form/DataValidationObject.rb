
class ::Magnets::HTML::Form::DataValidationObject

  DataValidationStorageConstant = :DataValidationObject

  @data_validation_storage = { }

  #######################################
  #  self.create_data_validation_class  #
  #######################################
  
  def self.create_data_validation_class( view_or_form_class )
    
    unless data_validation_class = @data_validation_storage[ view_or_form_class ]
      
      # Create a new subclass of DataValidationObject for view_or_form_class
      data_validation_class = ::Class.new( self ) do
        
        # intialize class instance vars for subclass
        @inputs = { }
        @subviews = { }
        
        @view_class = view_or_form_class
        
      end
    
      view_or_form_class.const_set( self::DataValidationStorageConstant, data_validation_class )
    
      @data_validation_storage[ view_or_form_class ] = data_validation_class
      
    end
        
    return data_validation_class
    
  end

  ################
  #  view_class  #
  ################
  
  def view_class
    
    return @view_class
    
  end

  ############
  #  inputs  #
  ############
  
  def inputs
    
    return @inputs
    
  end

  ##############
  #  subviews  #
  ##############
  
  def subviews
    
    return @subviews
    
  end
  
  #######################
  #  self.define_input  #
  #######################
  
  def self.define_input( input_binding )
        
    variable_name = input_binding_name.variable_name
    
    @inputs[ input_binding_name ] = input_binding
    
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

  #########################
  #  self.define_subview  #
  #########################
  
  def self.define_subview( subview_binding_name )

    # get the binding configuration
    subview_binding_instance = view_class.__binding__( subview_binding_name )
    data_validation_class = subview_binding_instance.__view_class__::DataValidationClass

    @subviews[ subview_binding_name ] = data_validation_class
    
    variable_name = subview_binding_name.variable_name
    
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
    
    self.class.subviews.each do |this_subview_binding_name, this_validated_data_class|

      # instantiate DataValidationObject for view class
      this_subview_data_object = this_validated_data_class.new
      instance_variable_set( this_subview_binding_name.variable_name, this_subview_data_object )

    end
    
  end
  
end
