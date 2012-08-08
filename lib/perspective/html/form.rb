
begin ; require 'development' ; rescue ::LoadError ; end

require 'perspective/html/elements'
require 'perspective/html/view_model'
require 'perspective/request'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

# post-require setup
require_relative './setup.rb'

module ::Perspective::HTML::Form

	extend ::Module::Cluster
	
	extend ::Perspective::HTML::Form::Context

  include ::Perspective::HTML::Elements::Form::Interface

	include ::Perspective::HTML::ViewModel
	
	include ::Perspective::HTML::Form::ObjectInstance
	
	cluster( :perspective ).before_include_or_extend.cascade.extend( ::Perspective::HTML::Form::ClassInstance )
	
	# Unlike other containers, in this case we actually need to be a Form to start.
	# This is because we expect all forms to have a hidden input with the form processing path.
	# Also because we are the first general container that corresponds to a specific tag.
	extend ::Perspective::HTML::Form::ClassInstance
	hidden_input_name = __hidden_input_for_form_route_input_name__
	encapsulation = ::CascadingConfiguration::Core::Encapsulation.encapsulation( :default )
	attr_hidden_input __hidden_input_for_form_route_binding_name__ do |hidden_input_instance|
	  hidden_input_instance.name = hidden_input_name
	  hidden_input_instance.__value__ = __route_string__
  end

end
