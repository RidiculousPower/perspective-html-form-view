
module ::Perspective::HTML::Form::ClassAndObjectInstance

  ################
  #  action      #
  #  __action__  #
  ################

  attr_configuration  :__action__

  Controller.alias_module_and_instance_methods( :action, :__action__ )
    
  def __action__=( action_method_GET_or_POST )
    
    case action = action_method_GET_or_POST.upcase

      when :GET, :POST

        super( action )

    end
    
  end
  
  alias_method( :action=, :__action__= )

  self.__action__ = :POST

  ###########
  #  post!  #
  #  POST!  #
  ###########

  def post!
    
    self.__action__ = :POST
    
  end
  
  alias_method( :POST!, :post! )

  ##########
  #  get!  #
  #  GET!  #
  ##########
  
  def get!
    
    self.__action__ = :GET

  end

  alias_method( :GET!, :get! )

  ###########
  #  post?  #
  #  POST?  #
  ###########

  def post?
    
    return __action__ == :POST
    
  end
  
  alias_method( :POST?, :post? )

  ##########
  #  get?  #
  #  GET?  #
  ##########
  
  def get?
    
    return __action__ == :GET

  end

  alias_method( :GET?, :get? )
  
end
