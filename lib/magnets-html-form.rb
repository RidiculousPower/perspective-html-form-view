
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

  'DataValidationObject',

  'Bindings/ClassBinding',
  'Bindings/InstanceBinding',
  
  'Binding',
  'Binding/FormSupport',

  'Input',
  'Input/ButtonInput',
  'Input/CheckboxInput',
  'Input/ColorInput',
  'Input/DataListInput',
  'Input/DateInput',
  'Input/DateTimeInput',
  'Input/EmailInput',
  'Input/FileUploadInput',
  'Input/HiddenInput',
  'Input/MonthInput',
  'Input/NumberInput',
  'Input/PasswordInput',
  'Input/RadioInput',
  'Input/RangeInput',
  'Input/SearchInput',
  'Input/SelectInput',
  'Input/TelephoneInput',
  'Input/TextInput',
  'Input/Text/TextAreaInput',
  'Input/TimeInput',
  'Input/URLInput',
  'Input/WeekInput',
  
  'View/ClassInstance',
  'View/ObjectInstance',
  
  'ClassInstance',
  'ObjectInstance',
  
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
