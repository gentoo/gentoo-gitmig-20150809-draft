# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/mt-st/mt-st-0.7.ebuild,v 1.8 2002/09/16 16:50:52 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Enhanced mt command for Linux, supporting Linux 2.4 ioctls"
SRC_URI="http://www.ibiblio.org/pub/linux/system/backup/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/tar/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:g" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dosbin mt stinit
	doman mt.1 stinit.8
}
