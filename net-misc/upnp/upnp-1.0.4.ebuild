# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/upnp/upnp-1.0.4.ebuild,v 1.7 2003/11/28 10:40:12 aliz Exp $

S="${WORKDIR}/${PN}sdk-${PV}"

DESCRIPTION="Intel's UPnP SDK"
HOMEPAGE="http://upnp.sourceforge.net"
SRC_URI="mirror://sourceforge/upnp/${PN}sdk-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"

RDEPEND="sys-fs/e2fsprogs"
DEPEND="${RDEPEND}"

src_compile() {
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
