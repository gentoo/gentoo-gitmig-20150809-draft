# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/revelation/revelation-0.4.7.ebuild,v 1.1 2006/12/29 11:42:55 nyhm Exp $

inherit python gnome2

DESCRIPTION="A password manager for GNOME"
HOMEPAGE="http://oss.codepoet.no/revelation/"
SRC_URI="ftp://oss.codepoet.no/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-python/gnome-python-desktop-2.16
	>=dev-python/pygtk-2.10.3
	dev-python/pycrypto
	sys-libs/cracklib"

src_unpack() {
	gnome2_src_unpack
	ln -sf /bin/true py-compile
	sed -i 's/gnome.applet/gnomeapplet/' \
		src/wrap/gnomemisc/gnomemisc.override \
		|| die "sed failed"
}

src_compile() {
	gnome2_src_compile \
		--disable-dependency-tracking \
		--disable-desktop-update \
		--disable-mime-update
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README TODO" \
	gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize "${ROOT}"usr/lib/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup
}
