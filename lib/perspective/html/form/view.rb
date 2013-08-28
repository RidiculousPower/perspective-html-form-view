# -*- encoding : utf-8 -*-

require 'perspective/html/elements'
require 'perspective/request'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

module ::Perspective::HTML::Form::View

	include ::Perspective::HTML::View

	extend ::Module::Cluster
	cluster( :perspective ).before_include_or_extend.cascade.extend( ::Perspective::HTML::Form::View::SingletonInstance )
	extend ::Perspective::HTML::Form::View::Context
	
	include ::Perspective::HTML::Form::View::ObjectInstance
  include ::Perspective::HTML::Elements::Form::FormInterface
	
end
