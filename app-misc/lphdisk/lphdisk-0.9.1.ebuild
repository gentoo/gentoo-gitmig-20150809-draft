# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lphdisk/lphdisk-0.9.1.ebuild,v 1.1 2002/07/19 04:17:29 chadh Exp $

S=${WORKDIR}/${P}

DESCRIPTION="utility for preparing a hibernation partition for APM Suspend-To-Disk"
HOMEPAGE="http://www.procyon.com/~pda/lphdisk/"
SRC_URI="http://www.procyon.com/~pda/lphdisk/${P}.tar.bz2"
LICENSE="Artistic"
SLOT="0"
# <chadh@gentoo.org>  I haven't actually tested that this doesn't work
# on all the below - arches, but it won't work.  This only works on x86
# laptops with Phoenix NoteBIOS.
KEYWORDS="x86 -ppc -sparc -mips"

src_compile() {
	sed "s:/usr/local:usr:" Makefile > Makefile.orig
	sed -e "s:-g -Wall:${CFLAGS}:" Makefile.orig > Makefile
	make
}

src_install() {
	#cd ${S}
	dosbin lphdisk
	doman lphdisk.8
}
