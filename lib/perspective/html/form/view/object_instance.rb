# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::ObjectInstance
  
  include ::Perspective::HTML::View::ObjectInstance
  
  include ::Perspective::HTML::Form::View::Configuration

  include ::CascadingConfiguration::Setting
  
  self.«container_tag» = :form

  ##################################################
  #  «input_name_for_hidden_input_for_form_route»  #
  ##################################################

  # We need to be able to identify the form binding route from other form inputs.
	# Since we want to be able to redraw the form without first reloading a url we don't want
	# to change the URL as a way of passing the form binding route. Instead, we pass the route
	# as a hidden input.
	#
	# We want the name to be unique and preferably short, since it will appear in GET strings.
	# 
	attr_singleton_configuration  :«input_name_for_hidden_input_for_form_route»

  ##########################################################
  #  «input_name_for_hidden_input_for_form_route» Default  #
  ##########################################################

  self.«input_name_for_hidden_input_for_form_route» = '«Form»'
  
  ##############################
  #  «subform_container_tag»   #
  #  «subform_container_tag»=  #
  ##############################

	attr_configuration  :«subform_container_tag»

  ###########################
  #  subform_container_tag  #
  ###########################

  self::Controller.alias_module_and_instance_methods( :subform_container_tag, :«subform_container_tag» )

  ############################
  #  subform_container_tag=  #
  ############################

  self::Controller.alias_module_and_instance_methods( :subform_container_tag=, :«subform_container_tag»= )

  #####################################
  #  «subform_container_tag» Default  #
  #####################################

  self.«subform_container_tag» = :div
  
  ######################################
	#  initialize«from_form_parameters»  #
  ######################################
	
  def initialize«from_form_parameters»

    # we have 'path-to-binding' => value
    # we want to turn it into path.to.binding = value
    ::Perspective.request.raw_parameters.each do |this_parameter_route_name, this_parameter_value|

      # The current data validation context.
      this_context = self
      
      # The post/put name we are splitting into nested hash values.
      this_route_remainder = this_parameter_route_name

      # We need a break variable to double-break from our inner loop.
      badly_formed_route = false

      while this_index = this_route_remainder.index( ::Perspective::Bindings::RouteDelimiter )
        # slice off route part up to delimiter
        this_route_part = this_route_remainder.slice( 0, this_index )
        # keep remainder
        length_parsed = this_index + ::Perspective::Bindings::RouteDelimiterLength
        this_remainder_length = this_route_remainder.length - length_parsed
        remainder_slice_index = this_index + ::Perspective::Bindings::RouteDelimiterLength
        this_route_remainder = this_route_remainder.slice( remainder_slice_index, this_remainder_length )
        # if we got badly formed parameter route name, skip to the next parameter
        unless this_context = this_context.«binding»( this_route_part )
          badly_formed_route = true
          break
        end
      end
      
      # If we got badly formed parameter input name, skip to the next parameter.
      # 
      # We don't want to allow someone to break the route and try the next route part as an input on the broken element.
      # For instance if we have /path/to/route and "to" is a badly formed route, "route" could end up getting called 
      # on "path" as an assignment value.
      #
      if badly_formed_route
        badly_formed_route = false
        next
      end
        
      # last remaining part is binding name for input corresponding to value
      this_input_name = this_route_remainder

      if this_input_binding_instance = this_context.«binding»( this_input_name )
        this_input_binding_instance.«value» = this_parameter_value
      end
      
    end
    
    return self
    
  end

  ################
  #  validates?  #
  ################

  def validates?
    
    return inputs_validate? ? validation_procs_validate? : false
    
  end
  
  ######################
  #  inputs_validate?  #
  ######################

  def inputs_validate?
    
    validates = true
    
    «input_bindings».each { |this_input_binding| validates = false unless this_input_binding.value_validates? }
    
    return validates
    
  end
  
  ################################
  #  validation_procs_validate?  #
  ################################

  def validation_procs_validate?

    validates = false

		«validation_procs».each { |this_validation_proc| break unless validates = instance_exec( & this_validation_proc ) }
    
    return validates

  end

  ##############
  #  success!  #
  ##############

  def success!

    «success_procs».each { |this_success_proc| instance_exec( & this_success_proc ) }

  end
  
  ##############
  #  failure!  #
  ##############
  
  def failure!

    «failure_procs».each { |this_failure_proc| instance_exec( & this_failure_proc ) }
    
  end
  
  ##################
  #  to_html_node  #
  ##################

  def to_html_node( document = «initialize_document», view_rendering_empty = @«view_rendering_empty» )

    self.«container_tag» = «subform_container_tag» if nested?
    
    self_as_html_node = super

    unless nested?
      hidden_binding_node = «create_hidden_form_path_input»( self_as_html_node.document )
      self_as_html_node.add_child( hidden_binding_node )
    end
    
    return self_as_html_node
    
  end

  #####################################
  #  «create_hidden_form_path_input»  #
  #####################################
  
  def «create_hidden_form_path_input»( document )
    
    hidden_binding_node = ::Nokogiri::XML::Node.new( 'input', document )

    hidden_binding_node[ 'name' ] = ::Perspective::HTML::Form::View.«input_name_for_hidden_input_for_form_route»
    hidden_binding_node[ 'type' ] = 'hidden'
    hidden_binding_node[ 'value' ] = «route_string».to_s
    
    return hidden_binding_node
    
  end
  
end
