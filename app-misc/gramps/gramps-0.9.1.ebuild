# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-0.9.1.ebuild,v 1.1 2003/04/23 22:01:12 liquidx Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Genealogical Research and Analysis Management Programming System"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"
HOMEPAGE="http://gramps.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-2.0
	>=dev-python/gnome-python-1.99
	dev-python/PyXML
	dev-python/Imaging
	dev-python/ReportLab"

DOCS="COPYING NEWS README TODO"

src_install() {
	gnome2_src_install
	
	# fix menu entry location
	dodir /usr/share/applications
	mv ${D}/usr/share/gnome/apps/Applications/gramps.desktop \
		${D}/usr/share/applications
	rm -rf ${D}/usr/share/gnome
}
