# -*- encoding : utf-8 -*-

class ::Perspective::Bindings::Exception::FormBindingExpected < ::ArgumentError
  
  def initialize( binding_instance )
    
    exception_string =  'Expected form binding at ' << binding_instance.«route_print_string»
    
    bound_instance = binding_instance.«bound_container».inspect
    
    exception_string << ' (defined in ' << bound_instance << ') does not refer to a form view class.'
    
  end
  
end
