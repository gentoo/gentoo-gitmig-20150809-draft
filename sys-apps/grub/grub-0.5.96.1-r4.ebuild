# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# /home/cvsroot/gentoo-x86/sys-apps/grub/grub-0.5.96.1-r2.ebuild,v 1.2 2001/02/07 20:05:43 achim Exp

S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/grub"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure --prefix=/usr sbindir=/sbin --mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST} || die
	emake -e CPPFLAGS="-Wall -Wmissing-prototypes -Wunused -Wshadow -malign-jumps=1 -malign-loops=1 -malign-functions=1 -Wundef" || die
}

src_install() {
	try make prefix=${D}/usr sbindir=${D}/sbin mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	
	if [ -z "`use bootcd`" ]
	then
        dodir /boot/grub
		cd ${D}/usr/share/grub/i386-pc
		cp stage1 stage2 *stage1_5 ${D}/boot/grub
		
        cd ${S}
		dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
	else
		rm -rf ${D}/usr/share/{man,info,doc}
	fi
}
