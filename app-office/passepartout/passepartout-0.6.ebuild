# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/passepartout/passepartout-0.6.ebuild,v 1.1 2005/04/02 04:31:48 usata Exp $

inherit gnome2

IUSE=""

DESCRIPTION="A DTP application for the X Window System"
HOMEPAGE="http://www.stacken.kth.se/project/pptout/"
SRC_URI="http://www.stacken.kth.se/project/pptout/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="=dev-cpp/libxmlpp-1.0*
	dev-libs/libxslt
	virtual/ghostscript
	=dev-cpp/libgnomecanvasmm-2.0*
	=dev-cpp/gtkmm-2.2*
	=dev-libs/libsigc++-1.2*"

DOCS="AUTHORS BUGS ChangeLog INSTALL NEWS README THANKS TODO"
