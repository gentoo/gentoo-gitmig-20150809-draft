# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tleds/tleds-1.05_beta11.ebuild,v 1.3 2002/08/14 12:12:29 murphy Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P/eta11/}
DESCRIPTION="Blinks keyboard LEDs (Light Emitting Diode) indicating outgoing
and incoming network packets on selected network interface."
HOMEPAGE="http://www.hut.fi/~jlohikos/tleds/"
SRC_URI="http://www.hut.fi/~jlohikos/tleds/public/${MY_P/11/10}.tgz
	http://www.hut.fi/~jlohikos/tleds/public/${MY_P}.patch.bz2"
	 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="X? ( virtual/x11 )"


src_unpack() {
	unpack tleds-1.05beta10.tgz
	cd ${S}
	bzcat ${DISTDIR}/${MY_P}.patch.bz2 | patch  || die
	patch < ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {

	emake all || die
}

src_install () {
	
	dobin tleds

	use X && dobin xtleds

	doman tleds.1
	dodoc README COPYING Changes
}
