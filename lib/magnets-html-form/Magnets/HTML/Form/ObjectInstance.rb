
module ::Magnets::HTML::Form::ObjectInstance

  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array::Unique
  include ::CascadingConfiguration::Hash
  
  include ::Magnets::HTML::View::ObjectInstance

  self.__container_tag__ = 'form'
  
  ccm = ::CascadingConfiguration::Methods
  
  ###############################
  #  subform_container_tag      #
  #  __subform_container_tag__  #
  ###############################

	attr_configuration  :__subform_container_tag__

  ccm.alias_module_and_instance_methods( self, :subform_container_tag, :__subform_container_tag__ )

  self.__subform_container_tag__ = 'div'

  ########################
  #  __input_bindings__  #
  ########################

  attr_configuration_hash          :__input_bindings__

  ##########################
  #  __validation_procs__  #
  ##########################

  attr_configuration_unique_array  :__validation_procs__
  
  #######################
  #  __success_procs__  #
  #######################

  attr_configuration_unique_array  :__success_procs__
  
  #######################
  #  __failure_procs__  #
  #######################

  attr_configuration_unique_array  :__failure_procs__
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
  ##############################
  #  __initialize_html_node__  #
  ##############################
  
  def __initialize_html_node__( document_frame )
    
    html_node = nil
    
    # if we are a subform, we need a div container instead of a form container
    if __binding__ and __binding__.rendering_inside_form?
      html_node = ::Nokogiri::XML::Node.new( __subform_container_tag__, document_frame )
    else
      html_node = ::Nokogiri::XML::Node.new( __container_tag__, document_frame )
    end
    
    return html_node
    
  end
  
end
