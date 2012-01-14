# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/revelation/revelation-0.4.11-r2.ebuild,v 1.9 2012/01/14 18:07:21 tristan Exp $

inherit autotools eutils multilib python gnome2

DESCRIPTION="A password manager for GNOME"
HOMEPAGE="http://oss.codepoet.no/revelation/"
SRC_URI="ftp://oss.codepoet.no/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="applet"
RESTRICT="test"

RDEPEND="dev-python/pygtk
	dev-python/pycrypto
	dev-python/gconf-python
	dev-python/gnome-vfs-python
	dev-python/libbonobo-python
	dev-python/libgnome-python
	sys-libs/cracklib
	applet? ( dev-python/gnome-applets-python )"
DEPEND="${RDEPEND}"

src_unpack() {
	gnome2_src_unpack
	echo -n > py-compile
	epatch \
		"${FILESDIR}"/${P}-list-index.patch \
		"${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_compile() {
	gnome2_src_compile \
		--disable-dependency-tracking \
		--disable-desktop-update \
		--disable-mime-update \
		$(use_enable applet)
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README TODO" \
	gnome2_src_install
	python_clean_installation_image
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize $(python_get_sitedir)/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup $(python_get_sitedir)/${PN}
}
