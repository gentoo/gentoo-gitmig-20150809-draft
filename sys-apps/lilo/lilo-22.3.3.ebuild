# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-22.3.3.ebuild,v 1.2 2002/09/30 01:18:25 woodchip Exp $

inherit mount-boot

S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="http://home.san.rr.com/johninsd/pub/linux/lilo/${P}.tar.gz
	ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/${P}.tar.gz"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"

KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"
LICENSE="BSD"

DEPEND="virtual/glibc
	>=sys-devel/bin86-0.15.5"

RDEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:\$(OPT) -Wall -g:-Wall ${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {

	emake || die
}

src_install() {

	into /
	dosbin lilo mkrescue
	into /usr
	dosbin keytab-lilo.pl
	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b boot-bmp.b chain.b mbr.b os2_d.b
	
	insinto /etc
	newins ${FILESDIR}/lilo.conf lilo.conf.example
	
	doman manPages/*.[5-8]
	dodoc CHANGES COPYING COPYRIGHT INCOMPAT QuickInst README*

	docinto samples
	dodoc sample/*
}

pkg_preinst() {

	if [ ! -L ${ROOT}/boot/boot.b -a -f ${ROOT}/boot/boot.b ]
	then
		einfo "Saving old boot.b..."
		mv -f ${ROOT}/boot/boot.b ${ROOT}/boot/boot.old; 
	fi

	if [ ! -L ${ROOT}/boot/chain.b -a -f ${ROOT}/boot/chain.b ]
	then
		einfo "Saving old chain.b..."
		mv -f ${ROOT}/boot/chain.b ${ROOT}/boot/chain.old;
	fi

	if [ ! -L ${ROOT}/boot/mbr.b -a -f ${ROOT}/boot/mbr.b ]
	then
		einfo "Saving old mbr.b..."
		mv -f ${ROOT}/boot/mbr.b ${ROOT}/boot/mbr.old
	fi

	if [ ! -L ${ROOT}/boot/os2_d.b -a -f ${ROOT}/boot/os2_d.b ]
	then
		einfo "Saving old os2_d.b..."
		mv -f ${ROOT}/boot/os2_d.b ${ROOT}/boot/os2_d.old;
	fi
}

pkg_postinst() {

	einfo "Activating boot-menu..."
	ln -snf boot-menu.b ${ROOT}/boot/boot.b
}

