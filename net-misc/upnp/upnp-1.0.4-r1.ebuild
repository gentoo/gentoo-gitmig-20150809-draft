# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/upnp/upnp-1.0.4-r1.ebuild,v 1.4 2004/03/23 18:59:09 mholzer Exp $

S="${WORKDIR}/${PN}sdk-${PV}"

DESCRIPTION="Intel's UPnP SDK"
HOMEPAGE="http://upnp.sourceforge.net"
SRC_URI="mirror://sourceforge/upnp/${PN}sdk-${PV}.tar.gz"
RESTRICT="nomirror"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"

DEPEND="sys-fs/e2fsprogs"

src_compile() {
	epatch ${FILESDIR}/msmessenger.patch
	emake || die "compile problem"
}

src_install () {
	dolib.so bin/libupnp.so

	dodir /usr/include/upnp
	dodir /usr/include/upnp/tools
	dodir /usr/include/upnp/upnpdom

	insinto /usr/include/upnp
	doins inc/*.h
	insinto /usr/include/upnp/tools
	doins inc/tools/*.h
	insinto /usr/include/upnp/upnpdom
	doins inc/upnpdom/*.h
	docinto sample
	dodoc LICENSE README
}
