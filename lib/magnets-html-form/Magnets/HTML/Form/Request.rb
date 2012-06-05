
module ::Magnets::HTML::Form::Request

  ###########################
	#  initialize_parameters  #
  ###########################
	
  def initialize_parameters( form_root_class )
    
    @parameters = form_root_class.__data_validation_class__.new
    
    # we have 'path-to-binding' => value
    # we want to turn it into path.to.binding = value
    raw_parameters.each do |this_parameter_route_name, this_parameter_value|
      
      # this_input_location points to the present hash lookup context
      this_input_location = @parameters
      
      # this_route_remainder is the post/put name we are splitting into nested hash values
      this_route_remainder = this_parameter_route_name

      badly_formed_route = false

      while this_index = this_route_remainder.index( ::Magnets::Bindings::RouteDelimiter )
        
        # slice off route part
        this_route_part = this_route_remainder.slice( 0, this_index )

        # keep remainder
        this_remainder_length = this_route_remainder.length - this_index - 1
        this_route_remainder = this_route_remainder.slice( this_index + 1, this_remainder_length )

        # if we got badly formed parameter route name, skip it
        if this_input_location.respond_to?( this_route_part )
          this_input_location = this_input_location.__send__( this_route_part )
        else
          badly_formed_route = true
          break
        end
        
      end
      
      # We don't want to allow someone to break the route and try the next route part
      # as an input on the broken element.
      # For instance if we have /path/to/route and "to" is a badly formed route, "route"
      # would end up getting called on "path" as an assignment value.
      if badly_formed_route
        badly_formed_route = false
        next
      end
        
      # last remaining part is binding name for input corresponding to value
      this_input_name = this_route_remainder

      # if we got badly formed parameter input name, skip it
      if this_input_location.respond_to?( this_input_name.write_accessor_name )
        this_input_location.__send__( this_input_name.write_accessor_name, this_parameter_value )
      end
      
    end
    
    return @parameters
    
  end
	
	################
	#  parameters  #
  ################

  attr_reader :parameters

end
