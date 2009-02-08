# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glipper/glipper-1.0-r2.ebuild,v 1.3 2009/02/08 14:00:03 ford_prefect Exp $

GCONF_DEBUG="no"

inherit gnome2 python eutils multilib

DESCRIPTION="GNOME Clipboard Manager"
HOMEPAGE="http://glipper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/pygobject-2.6
	>=dev-python/pygtk-2.6
	>=dev-python/gconf-python-2.22.0
	>=dev-python/libgnome-python-2.22.0
	>=dev-python/gnome-applets-python-2.22.0
	>=dev-python/gnome-vfs-python-2.22.0
	>=gnome-base/gnome-desktop-2.10"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS"

src_unpack() {
	gnome2_src_unpack
	cd "${S}"

	epatch "${FILESDIR}"/${P}-binary-data.patch
	epatch "${FILESDIR}"/${P}-transparent.patch
}

src_install() {
	gnome2_src_install py_compile=true
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/glipper

	elog "Glipper has been completely rewritten as a panel applet. Please remove your"
	elog "existing ~/.glipper directory and then add glipper as a new panel applet."
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup
}
