# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::InputBinding::InstanceBinding

  include ::Perspective::HTML::Form::Configuration

  ######################
  #  value_validates?  #
  ######################

  def value_validates?( binding_value = «value» )
    
    validates = false
    
    if binding_value_valid?( binding_value )
      input_bindings = «input_bindings»
  		«validation_procs».each do |this_validation_proc|
  		  break unless validates = instance_exec( input_bindings, & this_validation_proc )
      end
    end
    
    return validates
    
  end
  
  ##############
  #  «value»=  #
  ##############
  
  def «value»=( object )
    
    return input.«value» = object
    
  end

  #############
  #  «value»  #
  #############
  
  def «value»

    return input.«value»
    
  end

  ##############
  #  success!  #
  ##############

  def success!

    «success_procs».each { |this_success_proc| instance_exec( & this_success_proc ) }
    
    return self
    
  end
  
  ##############
  #  failure!  #
  ##############
  
  def failure!

    «failure_procs».each { |this_failure_proc| instance_exec( & this_failure_proc ) }
    
    return self
    
  end

end
