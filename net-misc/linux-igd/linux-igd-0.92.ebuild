# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-igd/linux-igd-0.92.ebuild,v 1.1 2003/06/17 12:32:41 johnm Exp $

MY_PN="linuxigd"
S="${WORKDIR}/${PN}"

DESCRIPTION="Daemon that emulates Microsoft's Internet Connection Service (ICS)
	for UPnP-aware clients"
HOMEPAGE="http://linux-igd.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/linux-igd/${MY_PN}-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

RDEPEND="net-misc/upnp
	net-firewall/iptables"
DEPEND="${RDEPEND}"

src_compile() {
	cd ${S}
	
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
	exeinto /usr/bin
	doexe upnpd
	insinto /etc/linuxigd
	doins etc/*
	doins ${FILESDIR}/upnpd.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/rc_upnpd upnpd
	dodoc CHANGELOG LICENSE README SECURITY TODO
}

pkg_postinst() {
	einfo "Make sure your firewall routing broadcast packages"
	einfo "to 239.0.0.0/255.0.0.0 correctly. See"
	einfo "/usr/share/doc/${P}/README.gz"
	einfo "for more information."
}
