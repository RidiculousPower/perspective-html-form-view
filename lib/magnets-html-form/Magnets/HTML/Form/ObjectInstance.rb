
module ::Magnets::HTML::Form::ObjectInstance
  
  include ::Magnets::HTML::View::ObjectInstance
  
  include ::Magnets::HTML::Form::Configuration

  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array::Unique
  include ::CascadingConfiguration::Hash

	# Unlike other containers, in this case we actually need to be a Form to start.
	# This is because we expect all forms to have a hidden input with the form processing path.
	extend ::Magnets::HTML::Form::ClassInstance
  
  ccm = ::CascadingConfiguration::Methods
  
  ##########################################
  #  __hidden_input_name_for_form_route__  #
  ##########################################

  # We need to be able to identify the form binding route from other form inputs.
	# Since we want to be able to redraw the form without first reloading a url we don't want
	# to change the URL as a way of passing the form binding route. Instead, we pass the route
	# as a hidden input.
	#
	# We want the name to be unique and preferably short, since it will appear in GET strings.
	# 
	attr_module_configuration  :__hidden_input_name_for_form_route__

  self.__hidden_input_name_for_form_route__ = :_MFAR_
  	
  ###############################
  #  subform_container_tag      #
  #  __subform_container_tag__  #
  ###############################

	attr_configuration  :__subform_container_tag__

  ccm.alias_module_and_instance_methods( self, :subform_container_tag, :__subform_container_tag__ )

  self.__container_tag__ = :form
  self.__subform_container_tag__ = :div

  ################
  #  action      #
  #  __action__  #
  ################

  attr_configuration  :__action__

  ccm.alias_module_and_instance_methods( self, :action, :__action__ )

  def __action__=( action_method_GET_or_POST )
    
    case action = action_method_GET_or_POST.upcase

      when :GET, :POST

        super( action )

    end
    
  end
  
  alias_method( :action=, :__action__= )

  ###########
  #  post!  #
  #  POST!  #
  ###########

  def post!
    
    self.__action__ = :POST
    
  end
  
  alias_method( :POST!, :post! )

  ##########
  #  get!  #
  #  GET!  #
  ##########
  
  def get!
    
    self.__action__ = :GET

  end

  alias_method( :GET!, :get! )

  ###########
  #  post?  #
  #  POST?  #
  ###########

  def post?
    
    return __action__ == :POST
    
  end
  
  alias_method( :POST?, :post? )

  ##########
  #  get?  #
  #  GET?  #
  ##########
  
  def get?
    
    return __action__ == :GET

  end

  alias_method( :GET?, :get? )

  ################################
	#  initialize_form_parameters  #
  ################################
	
  def initialize_form_parameters( form_root_class )
    
    @__parameters__ = form_root_class::DataValidationClass.new
    
    # we have 'path-to-binding' => value
    # we want to turn it into path.to.binding = value
    raw_parameters.each do |this_parameter_route_name, this_parameter_value|
      
      # The current data validation context.
      this_input_location = @__parameters__
      
      # The post/put name we are splitting into nested hash values.
      this_route_remainder = this_parameter_route_name

      # We need a break variable to double-break from our inner loop.
      badly_formed_route = false

      while this_index = this_route_remainder.index( ::Magnets::Bindings::RouteDelimiter )
        
        # slice off route part
        this_route_part = this_route_remainder.slice( 0, this_index )

        # keep remainder
        this_remainder_length = this_route_remainder.length - this_index - 1
        this_route_remainder = this_route_remainder.slice( this_index + 1, this_remainder_length )

        # if we got badly formed parameter route name, skip to the next parameter
        if this_input_location.respond_to?( this_route_part )
          this_input_location = this_input_location.__send__( this_route_part )
        else
          badly_formed_route = true
          break
        end
        
      end
      
      # If we got badly formed parameter input name, skip to the next parameter.
      # 
      # We don't want to allow someone to break the route and try the next route part
      # as an input on the broken element.
      # For instance if we have /path/to/route and "to" is a badly formed route, "route"
      # could end up getting called on "path" as an assignment value.
      #
      if badly_formed_route
        badly_formed_route = false
        next
      end
        
      # last remaining part is binding name for input corresponding to value
      this_input_name = this_route_remainder

      if this_input_location.respond_to?( this_input_name.write_accessor_name )
        this_input_location.__send__( this_input_name.write_accessor_name, this_parameter_value )
      end
      
    end
    
    return @__parameters__
    
  end
    
end
