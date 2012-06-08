
module ::Magnets::HTML::Form

	extend ::ModuleCluster
	
	extend ::Magnets::HTML::Form::BindingContext

	include ::Magnets::HTML::ViewModel
	
	include ::Magnets::HTML::Form::ObjectInstance
	
	include_or_extend_cascades_prepend_extends( ::Magnets::HTML::Form::ClassInstance )
	
	# Unlike other containers, in this case we actually need to be a Form to start.
	# This is because we expect all forms to have a hidden input with the form processing path.
	extend ::Magnets::HTML::Form::ClassInstance

	attr_hidden_input  __hidden_input_for_form_route_binding_name__ do |hidden_form_name_input|
	  hidden_form_name_input.name = __hidden_input_for_form_route_binding_name__
	  hidden_form_name_input.__value__ = __route_string__
  end
			  
end
