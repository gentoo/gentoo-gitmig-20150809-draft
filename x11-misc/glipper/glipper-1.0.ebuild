# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glipper/glipper-1.0.ebuild,v 1.3 2007/09/09 20:28:16 swegener Exp $

GCONF_DEBUG="no"

inherit gnome2 python

DESCRIPTION="GNOME Clipboard Manager"
HOMEPAGE="http://glipper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}
	>=dev-python/pygtk-2.6
	>=dev-python/gnome-python-2.10
	>=dev-python/gnome-python-extras-2.10
	>=gnome-base/gnome-desktop-2.10"

DOCS="AUTHORS ChangeLog NEWS"

src_install() {
	gnome2_src_install py_compile=true
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/lib*/python*/site-packages/glipper

	elog "Glipper has been completely rewritten as a panel applet. Please remove your"
	elog "existing ~/.glipper directory and then add glipper as a new panel applet."
}

pkg_postrm() {
	python_mod_cleanup
}
