
require_relative '../../elements/lib/magnets-html-elements.rb'
require_relative '../../view-model/lib/magnets-html-view-model.rb'
require_relative '../../../request/lib/magnets-request.rb'

module ::Magnets
  module HTML
  	module Form
  	  module Bindings
      end
  		module ClassInstance
  		  module Bindings
  		    module Input
  	      end
  	    end
  		end
  		module Input
  		  module ClassInstance
        end
  	  end
  		module ObjectInstance
  		end
  		module View
  	  end
  	end
	end
end

basepath = 'magnets-html-form/Magnets/HTML/Form'

files = [

  'ClassInstance/ValidationDefinition',
  'ObjectInstance/ValidationDefinition',
  
  'ClassInstance',
  'ObjectInstance',

  'Bindings/ClassBinding',
  'Bindings/InstanceBinding',
  
  'Binding',
  'Binding/FormSupport',

  'Input',
  'Input/Button',
  'Input/Checkbox',
  'Input/Color',
  'Input/DataList',
  'Input/Date',
  'Input/DateTime',
  'Input/Email',
  'Input/FileUpload',
  'Input/Hidden',
  'Input/Month',
  'Input/Number',
  'Input/Password',
  'Input/Radio',
  'Input/Range',
  'Input/Search',
  'Input/Select',
  'Input/Telephone',
  'Input/Text',
  'Input/Text/TextArea',
  'Input/Time',
  'Input/URL',
  'Input/Week',
  
  'View/ClassInstance',
  'View/ObjectInstance',

  'DataValidationObject',
  
  'Request',
  
  'RackApplication'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )

module ::Magnets
  extend ::Magnets::HTML::Form::RackApplication
end

class ::Magnets::Request
  include ::Magnets::HTML::Form::Request
end
