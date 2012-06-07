
class ::Magnets::Bindings::Exception::FormBindingExpected < ::ArgumentError
  
  def initialize( binding_instance )
    
    exception_string =  'Expected form binding at ' << binding_instance.__route_print_string__
    
    bound_instance = nil
    if binding_instance.respond_to?( :__bound_container_class__ )
      bound_instance = binding_instance.__bound_container_class__.inspect
    else
      bound_instance = binding_instance.__bound_container__.inspect
    end
    
    exception_string << ' (defined in ' << bound_instance << ') does not refer to a form view class.'
    
  end
  
end
