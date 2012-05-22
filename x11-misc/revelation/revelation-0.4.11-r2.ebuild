# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/revelation/revelation-0.4.11-r2.ebuild,v 1.10 2012/05/22 16:46:15 tristan Exp $

EAPI=4

PYTHON_DEPEND="2"

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

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-list-index.patch \
		"${FILESDIR}"/${P}-build.patch
	eautoreconf
	python_convert_shebangs -r 2 .
	gnome2_src_prepare
	echo -n > py-compile
}

src_configure() {
	gnome2_src_configure \
		--disable-dependency-tracking \
		--disable-desktop-update \
		--disable-mime-update \
		$(use_enable applet)
}

src_install() {
	dodoc AUTHORS ChangeLog NEWS README TODO
	gnome2_src_install
	python_clean_installation_image
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize ${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup ${PN}
}
