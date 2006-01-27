# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plonelanguagetool/plonelanguagetool-0.5.ebuild,v 1.2 2006/01/27 02:42:37 vapier Exp $

inherit zproduct

DESCRIPTION="PloneLanguageTool provides a language chooser for Plone"
HOMEPAGE="http://www.sourceforge.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/PloneLanguageTool-${PV}.tar.gz"

LICENSE="GPL-1"
KEYWORDS="~x86"

DEPEND="=net-zope/plone-2.0*"

ZPROD_LIST="PloneLanguageTool"
