# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tleds/tleds-1.04.ebuild,v 1.2 2002/07/01 11:11:00 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Blinks keyboard LEDs (Light Emitting Diode) indicating outgoing
and incoming network packets on selected network interface."

HOMEPAGE="ttp://www.hut.fi/~jlohikos/tleds/"
SRC_URI="http://www.hut.fi/~jlohikos/tleds/public/${P}.tgz
http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${P}-FuRy.patch"

SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"


src_unpack() {
	unpack ${P}.tgz
	cd ${S}
	bzcat ${FILESDIR}/${P}-FuRy.patch | patch
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
