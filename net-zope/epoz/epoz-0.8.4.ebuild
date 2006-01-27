# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/epoz/epoz-0.8.4.ebuild,v 1.5 2006/01/27 02:31:32 vapier Exp $

inherit zproduct

DESCRIPTION=" Epoz allows you to edit Zope- or Plone-objects with a wysiwyg-editor. No plugins are required. You only have to use a recent browser (IE >= 5.5, Mozilla >= 1.3.1, Netscape >= 7.1) that supports Rich-Text-controls (called Midas for Mozilla)"
HOMEPAGE="http://mjablonski.zope.de/Epoz"
SRC_URI="http://mjablonski.zope.de/Epoz/releases/Epoz-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~amd64 ppc ~sparc x86"

ZPROD_LIST="Epoz"
