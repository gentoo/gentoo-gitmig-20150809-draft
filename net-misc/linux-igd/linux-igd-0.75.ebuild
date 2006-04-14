# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-igd/linux-igd-0.75.ebuild,v 1.13 2006/04/14 22:10:31 tester Exp $

MY_PN="gateway"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Daemon that emulates Microsoft's Internet Connection Service (ICS)
	for UPnP-aware clients"
HOMEPAGE="http://linux-igd.sourceforge.net"
SRC_URI="mirror://sourceforge/linux-igd/${MY_PN}-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="<net-misc/upnp-1.1
	net-firewall/iptables"

src_compile() {
	mv Makefile Makefile.orig
	sed <Makefile.orig >Makefile \
		-e "s|/etc/linuxigd|${D}/etc/linuxigd|" \
		-e "s|/usr/bin|${D}/usr/bin|"
	mv pmlist.cpp pmlist.cpp.orig
	sed <pmlist.cpp.orig >pmlist.cpp \
		-e 's|/usr/sbin/iptables|/sbin/iptables|g'
	emake || die "compile problem"
}

src_install () {
	dobin upnpd
	insinto /etc/linuxigd
	doins etc/*
	doins ${FILESDIR}/upnpd.conf
	newinitd ${FILESDIR}/rc_upnpd upnpd
	dodoc CHANGELOG LICENSE README SECURITY TODO
}

pkg_postinst() {
	einfo "Make sure your firewall routing broadcast packages"
	einfo "to 239.0.0.0/255.0.0.0 correctly. See"
	einfo "/usr/share/doc/${P}/README.gz"
	einfo "for more information."
}
