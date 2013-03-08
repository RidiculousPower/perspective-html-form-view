# -*- encoding : utf-8 -*-

module ::Perspective::HTML::Form::SingletonAndObjectInstance

  ##############
  #  «action»  #
  ##############

  attr_configuration  :«action»

  ###############
  #  «action»=  #
  ###############
  
  def «action»=( action_method_GET_or_POST )
    
    case action = action_method_GET_or_POST.upcase

      when :GET, :POST

        super( action )

    end
    
  end

  ############
  #  action  #
  ############
  
  Controller.alias_module_and_instance_methods( :action, :«action» )

  #############
  #  action=  #
  #############
    
  Controller.alias_module_and_instance_methods( :action=, :«action»= )  
  alias_method( :action=, :«action»= )

  ##############################
  #  «action» Default Setting  #
  ##############################

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
