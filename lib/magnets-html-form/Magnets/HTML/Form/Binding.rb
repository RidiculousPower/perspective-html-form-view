
module ::Magnets::HTML::Form::Binding

  extend ::ModuleCluster

  include_cascades_extends_to_class( ::Magnets::HTML::Form::ClassInstance::ValidationDefinition )

  include ::Magnets::HTML::Form::ObjectInstance::ValidationDefinition

	###################################  Runtime Verification  #######################################  
  
  #############################
  #  __validate_form_value__  #
  #############################

  def __validate_form_value__( form_value )

    validates = false

		__validation_procs__.each do |this_validation_proc|
		  break unless validates = this_validation_proc.call( form_value )
    end
    
    return validates

  end
  
end
