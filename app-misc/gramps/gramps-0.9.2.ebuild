# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-0.9.2.ebuild,v 1.1 2003/06/02 11:15:35 liquidx Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Genealogical Research and Analysis Management Programming System"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"
HOMEPAGE="http://gramps.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-1.99
	>=dev-python/gnome-python-1.99
	>=gnome-base/gnome-vfs-2.0
	>=dev-python/PyXML-0.7.1
	>=dev-python/Imaging-1.1.3
	>=dev-python/ReportLab-1.11"
	
DEPEND="${RDEPEND}
	dev-lang/swig"

DOCS="COPYING NEWS README TODO"

src_install() {
	gnome2_src_install
	
	# fix menu entry location
	dodir /usr/share/applications
	mv ${D}/usr/share/gnome/apps/Applications/gramps.desktop \
		${D}/usr/share/applications
	rm -rf ${D}/usr/share/gnome
}
