# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::View::SingletonAndObjectInstance

  ##############
  #  «action»  #
  ##############

  attr_configuration  :«action»

  ###############
  #  «action»=  #
  ###############
  
  def «action»=( get_or_post )
    
    case action = get_or_post.to_s.upcase
      when :GET, :POST
        super( action )
      else
        raise ::ArgumentError, ':GET or :POST expected; got :' << action.to_s << '.'
    end
    
  end

  ############
  #  action  #
  ############
  
  alias_method :action, :«action»
#  self::Controller.alias_module_and_instance_methods( :action, :«action» )

  #############
  #  action=  #
  #############
    
  alias_method :action=, :«action»=
#  self::Controller.alias_module_and_instance_methods( :action=, :«action»= )  

  ######################
  #  «action» Default  #
  ######################

  self.«action» = :POST

  ###########
  #  post!  #
  ###########

  def post!
    
    self.«action» = :POST
    
  end
  
  ###########
  #  POST!  #
  ###########

  alias_method( :POST!, :post! )

  ##########
  #  get!  #
  ##########
  
  def get!
    
    self.«action» = :GET

  end

  ##########
  #  GET!  #
  ##########

  alias_method( :GET!, :get! )

  ###########
  #  post?  #
  ###########

  def post?
    
    return «action» == :POST
    
  end
  
  ###########
  #  POST?  #
  ###########

  alias_method( :POST?, :post? )

  ##########
  #  get?  #
  ##########
  
  def get?
    
    return «action» == :GET

  end

  ##########
  #  GET?  #
  ##########

  alias_method( :GET?, :get? )
  
end
