# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.90-r2.ebuild,v 1.1 2001/10/31 20:12:23 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/grub"

DEPEND="virtual/glibc 
        >=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	for patchname in `ls ${FILESDIR}/${P}-r2/*.patch`
	do
		echo patch: ${patchname}
		patch -p1 < ${patchname} || die
	done
}

src_compile() {

	./configure --prefix=/usr --sbindir=/sbin --mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST} || die
	emake -e CPPFLAGS="-Wall -Wmissing-prototypes -Wunused -Wshadow -malign-jumps=1 -malign-loops=1 -malign-functions=1 -Wundef" || die

}

src_install() {

	make prefix=${D}/usr sbindir=${D}/sbin mandir=${D}/usr/share/man infodir=${D}/usr/share/info install || die

	if [ -z "`use bootcd`" ]
	then
		dodir /boot/grub
		cd ${D}/usr/share/grub/i386-pc
		cp stage1 stage2 *stage1_5 ${D}/boot/grub
		cp ${FILESDIR}/${P}/splash.xpm.gz ${D}/boot/grub
		dosym . /boot/boot		
		dosym /boot/grub/menu.lst /boot/grub/grub.conf
		cd ${S}
		dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
	else
		rm -rf ${D}/usr/share/{man,info,doc}
	fi
}
