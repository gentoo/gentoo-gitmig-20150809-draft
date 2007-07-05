# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/pynetworkmanager/pynetworkmanager-0.3-r1.ebuild,v 1.1 2007/07/05 18:07:10 drac Exp $

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
	epatch "${FILESDIR}"/${P}-gentoo-2.patch
}

src_compile() {
	echo "Byte compiling in post installation."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	use doc && dohtml *.html *.png
}

pkg_postinst() {
	xfce44_pkg_postinst
	python_mod_optimize "${ROOT}"/usr/lib*/python*/site-packages

	elog "Note: This version of pyNetworkManager doesn't support encrypted networks,"
	elog "and doesn't work with old versions so you need to remove file:"
	elog "~/.config/pyNetworkManager/stored-networks.conf."
	elog
	elog "You might need to edit /etc/dbus-1/system.d/NetworkManager.conf,"
	elog "into group=\"plugdev\" section:"
	elog
	elog "<allow own=\"org.freedesktop.NetworkManagerInfo\"/>"
	elog
	elog "And restart system dbus after: /etc/init.d/dbus restart."
}

pkg_postrm() {
	xfce44_pkg_postrm
	python_mod_cleanup "${ROOT}"/usr/lib*/python*/site-packages
}
