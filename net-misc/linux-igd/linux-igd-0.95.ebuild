# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-igd/linux-igd-0.95.ebuild,v 1.1 2007/01/22 06:01:40 antarus Exp $

MY_PN="linuxigd"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Daemon that emulates Microsoft's Internet Connection Service (ICS)
	for UPnP-aware clients"
HOMEPAGE="http://linux-igd.sourceforge.net"
SRC_URI="mirror://sourceforge/linux-igd/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="<net-misc/upnp-1.1
	net-firewall/iptables"


src_compile() {
	sed -i -e "s|/etc/linuxigd|${D}/etc/linuxigd|" \
		-e "s|/usr/bin|${D}/usr/bin|" Makefile

	emake || die "compile problem"
}

src_install () {
	dobin upnpd
	insinto /etc/linuxigd
	doins etc/*
	doins "${FILESDIR}/upnpd.conf"
	newinitd "${FILESDIR}/rc_upnpd" upnpd
	newconfd "${FILESDIR}/upnpd.confd" upnpd
	dodoc CHANGES INSTALL LICENSE
}

pkg_postinst() {
	einfo "Make sure your firewall routing broadcast packages"
	einfo "to 239.0.0.0/255.0.0.0 correctly. See"
	einfo "/usr/share/doc/${P}/README.gz"
	einfo "for more information."
}
