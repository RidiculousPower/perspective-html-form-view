# -*- encoding : utf-8 -*-

module ::Perspective::BindingTypes::HTMLFormViewInputBindings::InstanceBinding

  extend ::Forwardable

  ######################
  #  value_validates?  #
  ######################

  def value_validates?( binding_value = «value» )
    
    validates = false
    
    if binding_value_valid?( binding_value )
      input_bindings = «input_bindings»
  		validates = «validation_procs».all? { |this_proc| instance_exec( input_bindings, & this_proc ) }
    end
    
    return validates
    
  end
  
  ##############
  #  «value»=  #
  ##############
  
  def_delegator :input, :«value»=

  #############
  #  «value»  #
  #############
  
  def_delegator :input, :«value»

  ##############
  #  success!  #
  ##############

  def success!

    «success_procs».each { |this_proc| instance_exec( & this_proc ) }
    
    return self
    
  end
  
  ##############
  #  failure!  #
  ##############
  
  def failure!

    «failure_procs».each { |this_proc| instance_exec( & this_proc ) }
    
    return self
    
  end

end
