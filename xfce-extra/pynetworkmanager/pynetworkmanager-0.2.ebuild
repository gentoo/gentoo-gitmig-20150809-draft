# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/pynetworkmanager/pynetworkmanager-0.2.ebuild,v 1.1 2007/07/01 06:54:06 drac Exp $

MY_PN="${PN/n/N}" ; MY_PN="${MY_PN/m/M}" ; MY_P="${MY_PN}-${PV}"

inherit eutils python xfce44

DESCRIPTION="Xfce4 Panel Plugin that connects to NetworkManager through DBUS."
HOMEPAGE="http://www.tfd.chalmers.se/~mk0foma/pyNetworkManager"
SRC_URI="http://www.tfd.chalmers.se/~mk0foma/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="net-misc/networkmanager
	dev-python/dbus-python
	dev-python/pyxfce
	dev-python/configobj
	xfce-base/xfce4-panel"
DEPEND=""

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	echo "Nothing to compile."
}

src_install() {
	exeinto /usr/share/xfce4/${MY_PN}
	doexe *.py

	insinto /usr/share/xfce4/${MY_PN}/icons
	doins icons/*.png

	insinto /usr/share/xfce4/panel-plugins
	doins ${MY_PN}.desktop

	use doc && dohtml *.html *.png
}

pkg_postinst() {
	xfce44_pkg_postinst
	python_mod_optimize /usr/share/xfce4/${MY_PN}
}

pkg_postrm() {
	xfce44_pkg_postrm
	python_mod_cleanup /usr/share/xfce4/${MY_PN}
}
