#! /usr/bin/env python

from os import chdir, stat
from distutils.core import setup, Extension

setup (# Distribution meta-data
        name = "ReportLab",
        version = "1.17",
        description = "Tools for generating printable PDF documents from any data source.",
        author = "ReportLab Inc.",
#        author_email = "",
       	license = """
#####################################################################################
#
#       Copyright (c) 2000-2001, ReportLab Inc.
#       All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without modification,
#       are permitted provided that the following conditions are met:
#
#               *       Redistributions of source code must retain the above copyright notice,
#                       this list of conditions and the following disclaimer. 
#               *       Redistributions in binary form must reproduce the above copyright notice,
#                       this list of conditions and the following disclaimer in the documentation
#                       and/or other materials provided with the distribution. 
#               *       Neither the name of the company nor the names of its contributors may be
#                       used to endorse or promote products derived from this software without
#                       specific prior written permission. 
#
#       THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#       ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#       IN NO EVENT SHALL THE OFFICERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
#       INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
#       TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#       OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
#       IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
#       IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
#       SUCH DAMAGE.
#
#####################################################################################""",
        long_description = "Tools for generating printable PDF documents from any data source.",
        url = "http://www.reportlab.com/",
	extra_path = "reportlab",
        package_dir = { '':'.' },
        packages = [ 'extensions',
                     'graphics', 'graphics/charts', 'graphics/widgets',
                     'lib', 'pdfbase', 'pdfgen', 'platypus',
                     'test', 'tools', 'tools/docco', 'tools/py2pdf',
                     'tools/pythonpoint', 'tools/pythonpoint/styles',
                     '.',
                     ],
#./fonts
      )

