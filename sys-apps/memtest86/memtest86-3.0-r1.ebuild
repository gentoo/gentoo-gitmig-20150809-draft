# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86/memtest86-3.0-r1.ebuild,v 1.1 2002/10/06 19:48:57 mkennedy Exp $

inherit mount-boot

S=${WORKDIR}/${P}
DESCRIPTION="A stand alone memory test for x86 computers"
SRC_URI="http://www.memtest86.com/${P}.tar.gz"
HOMEPAGE="http://www.memtest86.com/"
KEYWORDS="x86 -ppc -sparc -sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_install() {
	dodir /boot/memtest86
	cp precomp.bin ${D}/boot/memtest86/memtest.bin
	dodoc README README.build-process
}

pkg_postinst() {
	einfo '*** memtest.bin has been installed in /boot/memtest86, please remember to'
	einfo '*** update your boot loader. For example grub :'
	einfo "*** edit /boot/grub/menu.lst and add the following lines "
	einfo "***   > title=Memtest86"
	einfo "***   > root (hd0,0)"
	einfo "***   > kernel /boot/memtest86/memtest.bin"
}
