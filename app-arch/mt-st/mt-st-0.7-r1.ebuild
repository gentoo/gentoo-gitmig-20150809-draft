# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mt-st/mt-st-0.7-r1.ebuild,v 1.2 2003/07/18 19:14:23 tester Exp $

DESCRIPTION="Enhanced mt command for Linux, supporting Linux 2.4 ioctls"
HOMEPAGE="http://www.gnu.org/software/tar/"

S=${WORKDIR}/${P}
SRC_URI="http://www.ibiblio.org/pub/linux/system/backup/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:g" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dosbin mt stinit
	doman mt.1 stinit.8
	dodoc README* stinit.def.examples
}
