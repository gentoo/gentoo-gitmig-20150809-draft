# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-22.3.3-r1.ebuild,v 1.1 2002/09/22 21:48:31 woodchip Exp $

inherit mount-boot

S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"
DEPEND="virtual/glibc dev-lang/nasm >=sys-devel/bin86-0.15.5"
RDEPEND="virtual/glibc"
KEYWORDS="x86 -ppc -sparc -sparc64"
LICENSE="BSD"
SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz || die
	cd ${S} || die
	# groovy animated bootlogo patch, borrowed from suse and ported a bit
	# woodchip (sep 22 2002)
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
	    mv $ROOT/boot/boot.b $ROOT/boot/boot.old
	fi

	if [ ! -L $ROOT/boot/chain.b -a -f $ROOT/boot/chain.b ]
	then
	    einfo "Saving old chain.b..."
	    mv $ROOT/boot/chain.b $ROOT/boot/chain.old
	fi

	if [ ! -L $ROOT/boot/os2_d.b -a -f $ROOT/boot/os2_d.b ]
	then
	    einfo "Saving old os2_d.b..."
	    mv $ROOT/boot/os2_d.b $ROOT/boot/os2_d.old
	fi
}

pkg_postinst() {
	einfo "Activating boot-menu..."
	ln -sf boot-menu.b $ROOT/boot/boot.b

	einfo
	einfo "You can get some animations at:"
	einfo "http://www.gamers.org/~quinet/lilo/index.html"
	einfo
}
