# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-22.3.4.ebuild,v 1.7 2003/06/21 21:19:40 drobbins Exp $

inherit mount-boot eutils

S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="http://home.san.rr.com/johninsd/pub/linux/lilo/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"

SLOT="0"
LICENSE="BSD GPL-2"
KEYWORDS="x86 amd64 -ppc -sparc -alpha -mips"

DEPEND="dev-lang/nasm
	>=sys-devel/bin86-0.15.5"

PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${P}.tar.gz || die
	cd ${S} || die
	# This bootlogo patch is borrowed from SuSE Linux.
	# You should see Raphaël Quinet's (quinet@gamers.org) website,
	# http://www.gamers.org/~quinet/lilo/index.html
	epatch ${DISTDIR}/${P}-gentoo.diff.bz2
}

src_compile() {
	emake || die
}

src_install() {
	into /
	dosbin lilo activate mkrescue
	into /usr
	dosbin keytab-lilo.pl
	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b boot-bmp.b chain.b mbr.b os2_d.b
	doman manPages/*.[5-8]
	dodoc CHANGES COPYING INCOMPAT README*
	docinto samples ; dodoc sample/*
	insinto /etc
	newins ${FILESDIR}/lilo.conf lilo.conf.example
}

pkg_preinst() {
	mount-boot_mount_boot_partition
	if [ ! -L $ROOT/boot/boot.b -a -f $ROOT/boot/boot.b ]
	then
		einfo "Saving old boot.b..."
		mv -f $ROOT/boot/boot.b $ROOT/boot/boot.old
	fi

	if [ ! -L $ROOT/boot/chain.b -a -f $ROOT/boot/chain.b ]
	then
		einfo "Saving old chain.b..."
		mv -f $ROOT/boot/chain.b $ROOT/boot/chain.old
	fi

	if [ ! -L ${ROOT}/boot/mbr.b -a -f ${ROOT}/boot/mbr.b ]
	then
		einfo "Saving old mbr.b..."
		mv -f ${ROOT}/boot/mbr.b ${ROOT}/boot/mbr.old
	fi

	if [ ! -L $ROOT/boot/os2_d.b -a -f $ROOT/boot/os2_d.b ]
	then
		einfo "Saving old os2_d.b..."
		mv -f $ROOT/boot/os2_d.b $ROOT/boot/os2_d.old
	fi
}

pkg_postinst() {
	einfo "Activating boot-menu..."
	ln -sf boot-menu.b $ROOT/boot/boot.b
}
