from distutils.core import setup, Extension
from distutils.command.install_data import install_data
from compiler.pycodegen import compileFile
import glob
import distutils
import distutils.sysconfig
import distutils.core
import os

DISTUTILS_DEBUG="True"

VERSION='1.2.0'

LONG_DESCRIPTION="""\
Fast Artificial Neural Network Library implements multilayer
artificial neural networks with support for both fully connected
and sparsely connected networks. It includes a framework for easy 
handling of training data sets. It is easy to use, versatile, well 
documented, and fast. 
"""

setup(
	name='pyfann',
	description='Fast Artificial Neural Network Library (fann)',
	long_description=LONG_DESCRIPTION,
	version=VERSION,
	author='Steffen Nissen',
	author_email='lukesky@diku.dk',
	maintainer='Gil Megidish',
	maintainer_email='gil@megidish.net',
	url='http://sourceforge.net/projects/fann/',
	license='GNU LESSER GENERAL PUBLIC LICENSE (LGPL)',
	# Description of the package in the distribution
	packages=['fann'],
	ext_package="fann",
	ext_modules=[
		Extension("_libfann", ["fann_helper.c","libfann.i"],
			include_dirs=["../src/include"],
			extra_link_args=['-L/usr/local/bin','-L/usr/bin','-L../src/include','-lpython2.3','-dll'],
				extra_objects=['/var/tmp/portage/fann-1.2.0/work/fann-1.2.0/src/fann_error.o',
					'../src/fann_io.o','../src/fann.o','../src/fann_options.o',
					'../src/fann_train_data.o','../src/fann_train.o'],
			 )
		],
	)

