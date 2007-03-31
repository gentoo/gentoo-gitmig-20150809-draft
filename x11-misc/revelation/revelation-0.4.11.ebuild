# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/revelation/revelation-0.4.11.ebuild,v 1.4 2007/03/31 08:36:53 opfer Exp $

inherit python gnome2

DESCRIPTION="A password manager for GNOME"
HOMEPAGE="http://oss.codepoet.no/revelation/"
SRC_URI="ftp://oss.codepoet.no/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-python/gnome-python-desktop-2.16
	>=dev-python/pygtk-2.10.3
	dev-python/pycrypto
	sys-libs/cracklib
	dev-python/gnome-python-extras"

src_unpack() {
	gnome2_src_unpack
	ln -sf /bin/true py-compile
}

src_compile() {
	gnome2_src_compile \
		--disable-dependency-tracking \
		--disable-desktop-update \
		--disable-mime-update
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README TODO" gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize "${ROOT}"/usr/lib/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup
}
