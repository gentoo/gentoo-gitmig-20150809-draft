# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/revelation/revelation-0.4.11-r2.ebuild,v 1.6 2010/01/07 20:30:16 nyhm Exp $

inherit autotools eutils multilib python gnome2

DESCRIPTION="A password manager for GNOME"
HOMEPAGE="http://oss.codepoet.no/revelation/"
SRC_URI="ftp://oss.codepoet.no/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RESTRICT="test"

DEPEND="dev-python/pygtk
	dev-python/pycrypto
	dev-python/gnome-applets-python
	dev-python/gconf-python
	dev-python/gnome-vfs-python
	dev-python/libbonobo-python
	dev-python/libgnome-python
	sys-libs/cracklib"
RDEPEND="${DEPEND}"

src_unpack() {
	gnome2_src_unpack
	ln -sf $(type -P true) py-compile
	epatch \
		"${FILESDIR}"/${P}-list-index.patch \
		"${FILESDIR}"/${P}-build.patch
	eautoreconf
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
	python_version
	rm -f "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/crack.la
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup
}
