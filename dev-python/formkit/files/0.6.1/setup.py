#! /usr/bin/env python

from os import chdir, stat
from distutils.core import setup, Extension

setup (# Distribution meta-data
		name = "FormKit",
		version = "0.6.1",
		description = "Generation and validation of www forms. WebWare WebKit compatible. Can be used stand-alone.",
		author = "",
	   	license = "LGPL-2.1",
		long_description = "Generation and validation of www forms. WebWare WebKit compatible. Can be used stand-alone.",
		url = "http://dalchemy.com/opensource/formkit/",
	extra_path = "formkit",
		package_dir = { '':'.' },
		packages = [ '.', ],
#			'BaseChoiceClasses',
#			'BaseFieldClasses',
#			'BaseTagClasses',
#			'BaseValidatorClasses',
#			'Fields',
#			'Form',
#			'FormKitMixIn',
#			'Properties',
#			'Validators',
	  )

