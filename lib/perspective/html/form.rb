# -*- encoding : utf-8 -*-

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

	include ::Perspective::HTML::ViewModel
	
	include ::Perspective::HTML::Form::ObjectInstance

  include ::Perspective::HTML::Elements::Form::FormInterface
	
	cluster( :perspective ).before_include_or_extend.cascade.extend( ::Perspective::HTML::Form::SingletonInstance )

end
