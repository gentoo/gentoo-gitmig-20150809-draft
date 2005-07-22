# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firestarter/firestarter-1.0.3.ebuild,v 1.4 2005/07/22 11:05:38 corsair Exp $

inherit gnome2

DESCRIPTION="GUI for iptables firewall setup and monitor."
HOMEPAGE="http://www.fs-security.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc ppc64 ~sparc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	net-firewall/iptables
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.21"

DOCS="AUTHORS ChangeLog CREDITS INSTALL README TODO"

src_install() {
	gnome2_src_install
	newinitd "${FILESDIR}/${P}" "${PN}"
}

pkg_postinst() {
	gnome2_pkg_postinst
	echo
	einfo "Run /usr/bin/firestarter to configure and setup the firewall"
	einfo "If you would like to have firestarter start automatically,"
	einfo "add the init script to the default runlevel:"
	einfo "    rc-update add firestarter default"
	echo
	ewarn "If you are upgrading from a previous version of ${PN}"
	ewarn "be aware that ${P} doesn't allow LAN connections to the"
	ewarn "firewall machine by default."
	ewarn "You must explicitly set policy to allow connections from"
	ewarn "the LAN to the firewall box."
	echo
}
