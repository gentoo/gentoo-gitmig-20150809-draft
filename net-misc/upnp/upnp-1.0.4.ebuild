# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/upnp/upnp-1.0.4.ebuild,v 1.10 2004/07/15 03:42:14 agriffis Exp $

S="${WORKDIR}/${PN}sdk-${PV}"

DESCRIPTION="Intel's UPnP SDK"
HOMEPAGE="http://upnp.sourceforge.net"
SRC_URI="mirror://sourceforge/upnp/${PN}sdk-${PV}.tar.gz"
RESTRICT="nomirror"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="sys-fs/e2fsprogs"

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
