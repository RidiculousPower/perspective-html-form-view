# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::Configuration
  
  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array::Unique

  ###############
  #  «nested»   #
  #  «nested»=  #
  ###############

  attr_configuration :«nested»
  
  self.«nested» = false
  
  #############
  #  nested?  #
  #############

  def nested?

    return self.«nested»

  end

  #############
  #  nested!  #
  #############

  def nested!

    self.«nested» = true

  end

  ######################
  #  «input_bindings»  #
  ######################

  attr_unique_array  :«input_bindings» do
    
    #======================#
	  #  child_pre_set_hook  #
	  #======================#

	  def child_pre_set_hook( index, binding_instance, is_insert, parent_hash )

	    return configuration_instance.«binding»( binding_instance.«name» )
	    
	  end
	  
  end

  ####################
  #  input_bindings  #
  ####################

  self::Controller.alias_module_and_instance_methods( :input_bindings, :«input_bindings» )

  ########################
  #  «subform_bindings»  #
  ########################
  
  attr_unique_array  :«subform_bindings» do

    #======================#
	  #  child_pre_set_hook  #
	  #======================#

	  def child_pre_set_hook( index, binding_instance, is_insert, parent_hash )

	    return configuration_instance.«binding»( binding_instance.«name» )
	    
	  end
    
  end

  ######################
  #  subform_bindings  #
  ######################

  self::Controller.alias_module_and_instance_methods( :subform_bindings, :«subform_bindings» )

  ################
  #  «validate»  #
  ################
  
  def «validate»( & validation_proc )
  
    «validation_procs».push( validation_proc )
    
  end

  ##############
  #  validate  #
  ##############

  alias_method :validate, :«validate»

  ###############
  #  «failure»  #
  ###############

  def «failure»( & failure_proc )

    «failure_procs».push( failure_proc )

  end

  #############
  #  failure  #
  #############

  alias_method :failure, :«failure»
  
  ###############
  #  «success»  #
  ###############

  def «success»( & success_proc )

    «success_procs».push( success_proc )

  end

  #############
  #  success  #
  #############

  alias_method :success, :«success»

  ########################
  #  «validation_procs»  #
  ########################

  attr_unique_array  :«validation_procs» 

  ######################
  #  validation_procs  #
  ######################

  self::Controller.alias_module_and_instance_methods( :validation_procs, :«validation_procs»  )

  #####################
  #  «success_procs»  #
  #####################

  attr_unique_array  :«success_procs»

  ###################
  #  success_procs  #
  ###################

  self::Controller.alias_module_and_instance_methods( :success_procs, :«success_procs» )
  
  #####################
  #  «failure_procs»  #
  #####################

  attr_unique_array  :«failure_procs»

  ###################
  #  failure_procs  #
  ###################

  self::Controller.alias_module_and_instance_methods( :failure_procs, :«failure_procs» )

  ###########################
  #  «process_form_values»  #
  ###########################

  def «process_form_values»
    
    validates = «validate_form_values»
    validates ? «call_success_procs» : «call_failure_procs»

    return validates
    
  end

end
