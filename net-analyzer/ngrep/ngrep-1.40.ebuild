# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.40.ebuild,v 1.3 2002/05/27 17:27:39 drobbins Exp $

S=${WORKDIR}/ngrep
DESCRIPTION="A grep for network layers"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.gz"
HOMEPAGE="http://ngrep.sourceforge.net"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2"

RDEPEND="virtual/glibc"

src_compile() {
	
	econf || die
	make || die
}

src_install() {

	into /usr
	dobin ngrep
	doman ngrep.8
	dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}



