# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-19-r3.ebuild,v 1.15 2003/02/24 22:34:59 dragon Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Handy process-related utilities from Debian"
SRC_URI="ftp://lrcftp.epfl.ch/pub/linux/local/psmisc/${P}.tar.gz"
HOMEPAGE="http://psmisc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-ltermcap:-lncurses:g" \
		-e "s:-O:${CFLAGS}:" \
		-e "s:-Wpointer-arith::" \
		Makefile.orig > Makefile
}

src_compile() {
	pmake || die
}

src_install() {
	into /
	dobin killall pstree
	dosym killall /usr/bin/pidof
	
	into /
	dobin fuser
	
	doman *.1
	dodoc CHANGES COPYING README VERSION psmisc-19.lsm
}
