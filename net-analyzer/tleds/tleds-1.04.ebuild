# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tleds/tleds-1.04.ebuild,v 1.1 2002/07/01 10:57:15 seemant Exp $

DESCRIPTION="Blinks keyboard LEDs (Light Emitting Diode) indicating outgoing
and incoming network packets on selected network interface."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://"

LICENSE="GPL-2"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"

SRC_URI="http://www.hut.fi/~jlohikos/tleds/public/${P}.tgz"

S=${WORKDIR}/${P}

SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/${P}-FuRy.patch
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
