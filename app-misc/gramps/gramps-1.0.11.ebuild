# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-1.0.11.ebuild,v 1.1 2005/04/04 18:54:32 joem Exp $

inherit gnome2 eutils

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
HOMEPAGE="http://gramps.sourceforge.net/"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

RDEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-1.99.14
	>=dev-python/gnome-python-1.99.14
	>=gnome-base/gnome-vfs-2.0
	>=dev-python/pyxml-0.7.1
	>=dev-python/imaging-1.1.3
	>=dev-python/reportlab-1.11"

DEPEND="${RDEPEND}
	dev-lang/swig
	dev-util/pkgconfig
	app-text/scrollkeeper"

DOCS="NEWS README TODO"
MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {

	if ! built_with_use dev-python/pygtk gnome ; then
		eerror "You need to install pygtk with libglade support. Try:"
		eerror "USE='gnome' emerge pygtk"
		die "libglade support missing from pygtk"
	fi

}

src_install() {
	gnome2_src_install
	rm -rf ${D}/usr/share/gramps.desktop
}

USE_DESTDIR="1"
