# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lphdisk/lphdisk-0.9.1.ebuild,v 1.3 2002/10/15 09:02:45 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="utility for preparing a hibernation partition for APM Suspend-To-Disk"
HOMEPAGE="http://www.procyon.com/~pda/lphdisk/"
SRC_URI="http://www.procyon.com/~pda/lphdisk/${P}.tar.bz2"

# <chadh@gentoo.org>  I haven't actually tested that this doesn't work
# on all the below - arches, but it won't work.  This only works on x86
# laptops with Phoenix NoteBIOS.

SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64 -alpha"
LICENSE="Artistic"

src_compile() {
	sed "s:/usr/local:usr:" Makefile > Makefile.orig
	sed -e "s:-g -Wall:${CFLAGS}:" Makefile.orig > Makefile
	make || die
}

src_install() {
	dosbin lphdisk
	doman lphdisk.8
}
