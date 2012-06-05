
module ::Magnets::HTML::Form::ClassInstance::ValidationDefinition

  ###################################  Runtime Configuration  ######################################

  ##############
  #  validate  #
  ##############
  
  def validate( & validation_proc )
  
    __validation_procs__.push( validation_proc )
    
  end

  #############
  #  failure  #
  #############

  def failure( & failure_proc )

    __failure_procs__.push( failure_proc )

  end
  
  #############
  #  success  #
  #############

  def success( & success_proc )

    __success_procs__.push( success_proc )

  end
  
end
