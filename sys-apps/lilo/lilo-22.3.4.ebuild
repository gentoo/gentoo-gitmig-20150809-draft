# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-22.3.4.ebuild,v 1.1 2003/01/04 06:14:12 woodchip Exp $

inherit mount-boot

S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="http://home.san.rr.com/johninsd/pub/linux/lilo/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"
DEPEND="virtual/glibc dev-lang/nasm >=sys-devel/bin86-0.15.5"
RDEPEND="virtual/glibc"
KEYWORDS="~x86 -ppc -sparc"
LICENSE="BSD"
SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz || die
	cd ${S} || die
	#Again, this is my go at SuSE's animated bootlogo patch.
	#lilo-22.3.4-gentoo.diff; <woodchip@gentoo.org> (03 Jan 2003)
	bzip2 -dc ${DISTDIR}/${P}-gentoo.diff.bz2 | patch -p1 || die
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
	ln -snf boot-menu.b $ROOT/boot/boot.b

	einfo
	einfo "You can get some animations at:"
	einfo "http://www.gamers.org/~quinet/lilo/index.html"
	einfo
}
