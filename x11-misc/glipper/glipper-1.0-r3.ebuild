# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glipper/glipper-1.0-r3.ebuild,v 1.6 2011/10/19 22:54:28 tetromino Exp $

EAPI="3"

GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit gnome2 python eutils multilib

DESCRIPTION="GNOME Clipboard Manager"
HOMEPAGE="http://glipper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pygobject-2.6:2
	>=dev-python/pygtk-2.6
	>=dev-python/gconf-python-2.22.0
	>=dev-python/libgnome-python-2.22.0
	>=dev-python/gnome-applets-python-2.22.0
	>=dev-python/gnome-vfs-python-2.22.0
	>=gnome-base/gnome-desktop-2.10:2"
RDEPEND="${DEPEND}"

RESTRICT="test"

DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-binary-data.patch
	epatch "${FILESDIR}"/${P}-transparent.patch
	epatch "${FILESDIR}"/${P}-pkgconfig.patch
}

src_install() {
	gnome2_src_install py_compile=true

	python_convert_shebangs 2 "${D}"/usr/$(get_libdir)/glipper/glipper

	# remove pointless .la files, bug #305147
	rm -f "${D}$(python_get_sitedir)"/glipper/{keybinder/_keybinder,osutils/_osutils}.la
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize glipper

	elog "Glipper has been completely rewritten as a panel applet. Please remove your"
	elog "existing ~/.glipper directory and then add glipper as a new panel applet."
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup glipper
}
