
module ::Magnets::HTML::Form

	extend ::ModuleCluster

	include ::Magnets::HTML::ViewModel
	
	include ::Magnets::HTML::Form::ObjectInstance
	
	include_or_extend_cascades_prepend_extends( ::Magnets::HTML::Form::ClassInstance )
	  
  FormProcessingURLBase   = 'form_processing'
  self.__container_tag__ = 'form'
#  self.__sub_container_tag__ = 'div'
  
end
