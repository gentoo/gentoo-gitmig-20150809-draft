# Author: David Goodger
# Contact: goodger@users.sourceforge.net
# Revision: $Revision: 1.1 $
# Date: $Date: 2003/07/07 23:39:10 $
# Copyright: This module has been placed in the public domain.

"""
Gentoo Linux Enhancement Proposal (GLEP) Reader.
"""

__docformat__ = 'reStructuredText'


import sys
import os
import re
from docutils import nodes
from docutils.readers import standalone
from docutils.transforms import gleps, references
from docutils.parsers import rst


class Reader(standalone.Reader):

    supported = ('glep',)
    """Contexts this reader supports."""

    settings_spec = (
        'PEP Reader Option Defaults',
        'The --pep-references and --rfc-references options (for the '
        'reStructuredText parser) are on by default.',
        ())

    default_transforms = (references.Substitutions,
                          gleps.Headers,
                          gleps.Contents,
                          references.ChainedTargets,
                          references.AnonymousHyperlinks,
                          references.IndirectHyperlinks,
                          gleps.TargetNotes,
                          references.Footnotes,
                          references.ExternalTargets,
                          references.InternalTargets,)

    settings_default_overrides = {'pep_references': 1, 'rfc_references': 1}

    inliner_class = rst.states.Inliner

    def __init__(self, parser=None, parser_name=None):
        """`parser` should be ``None``."""
        if parser is None:
            parser = rst.Parser(rfc2822=1, inliner=self.inliner_class())
        standalone.Reader.__init__(self, parser, '')
