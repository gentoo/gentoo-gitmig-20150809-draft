# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-21.7.5-r1.ebuild,v 1.1 2002/02/03 03:46:22 woodchip Exp $

# NOTES:  Not finished yet, but completely usable.  Havent decided yet howto
#         package the boot animations, if any..  Also havent decided what to
#         do with the utils for making boot animations.. ie: include them in
#         this package, or make a separate package, as SuSE has done..
#
#         Remember to mount /boot before you merge this thing!

S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/${P}.tar.gz"

DEPEND="virtual/glibc >=sys-devel/bin86-0.15.5"
RDEPEND="virtual/glibc" #gfxboot

src_unpack() {
	unpack ${A} ; cd ${S}

	# patches for animated boot logo from Suse.  weeee! :>
	patch -p1 < ${FILESDIR}/${PV}/lilo-21.7.4.diff || die
	patch -p1 < ${FILESDIR}/${PV}/lilo-21.7.4-loop_dev.diff || die
	patch -p1 < ${FILESDIR}/${PV}/lilo-21.7.4-gfx.diff || die
	patch -p0 < ${FILESDIR}/${PV}/lilo-21.7-vga_inst.diff || die

	mv Makefile Makefile.orig
	sed -e "s:-g:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	make || die "compile problem"
}

src_install() {
	into /
	dosbin lilo
	into /usr
	dosbin keytab-lilo.pl
	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b chain.b os2_d.b
	doman manPages/*.[5-8]
	dodoc CHANGES COPYING INCOMPAT QuickInst README*

	#dodir /usr/share/lilo
	#hmm, maybe include some boot animations from the homepage
	#listed below, but we're required to redistribute the sources
	#for them too.. will decide soon.
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

	einfo "You need to put: message=/boot/foo.boot in your"
	einfo "/etc/lilo.conf global section."
	echo
	einfo "See http://www.gamers.org/~quinet/lilo/index.html"
	einfo "for downloadable animations.  Put them in your"
	einfo "/boot directory."
	echo
	einfo "Have fun :>"
}
