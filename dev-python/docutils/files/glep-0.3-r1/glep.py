#!/usr/bin/env python

# Author: David Goodger
# Contact: goodger@users.sourceforge.net
# Revision: $Revision: 1.1 $
# Date: $Date: 2003/07/07 23:39:10 $
# Copyright: This module has been placed in the public domain.

"""
A minimal front end to the Docutils Publisher, producing HTML from PEP
(Python Enhancement Proposal) documents.
"""

import locale
try:
    locale.setlocale(locale.LC_ALL, '')
except:
    pass

from docutils.core import publish_cmdline, default_description


description = ('Generates (X)HTML from reStructuredText-format PEP files.  '
               + default_description)

publish_cmdline(reader_name='glep', writer_name='glep_html',
                description=description)
