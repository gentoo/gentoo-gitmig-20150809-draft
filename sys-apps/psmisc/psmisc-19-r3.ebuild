# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-19-r3.ebuild,v 1.7 2002/09/14 15:51:25 bjb Exp $

#from Debian ;)

S=${WORKDIR}/psmisc
DESCRIPTION="Handy process-related utilities from Debian"
SRC_URI="ftp://lrcftp.epfl.ch/pub/linux/local/psmisc/${P}.tar.gz"
DEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2"
HOMEPAGE="http://psmisc.sourceforge.net/"
KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s/-ltermcap/-lncurses/g" \
		-e "s/-O/${CFLAGS}/" \
		-e "s:-Wpointer-arith::" \
		Makefile.orig > Makefile
}

src_compile() {
	pmake || die
}

src_install() {
	if [ "`use bootcd`" ]
	then
		into /
	fi
	dobin killall pstree
	dosym killall /usr/bin/pidof
	
	into /
	dobin fuser
	
	if [ -z "`use bootcd`" ]
	then
		doman *.1
		dodoc CHANGES COPYING README VERSION psmisc-19.lsm
	fi
}
