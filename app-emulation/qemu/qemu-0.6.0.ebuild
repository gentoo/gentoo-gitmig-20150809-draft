# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-0.6.0.ebuild,v 1.4 2004/10/28 07:11:14 lu_zero Exp $

inherit eutils

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://fabrice.bellard.free.fr/qemu/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ppc -alpha -sparc"
IUSE="softmmu qemu-fast sdl"
RESTRICT="nostrip"

DEPEND="virtual/libc
	sdl? ( media-libs/libsdl )"
RDEPEND=""

set_target_list() {
	TARGET_LIST="arm-user i386-user ppc-user sparc-user" #i386-softmmu ppc-softmmu
	use softmmu && TARGET_LIST="${TARGET_LIST} i386-softmmu ppc-softmmu"
	use qemu-fast && TARGET_LIST="${TARGET_LIST} i386"
	export TARGET_LIST
}

#RUNTIME_PATH="/emul/gnemul/"
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-typo.patch
	epatch ${FILESDIR}/${P}-sigaction.patch
	epatch ${FILESDIR}/qemu_gcc34.patch.gz
}

src_compile() {
	set_target_list
#		--interp-prefix=${RUNTIME_PATH}/qemu-%M
	./configure \
		--prefix=/usr \
		--target-list="${TARGET_LIST}" \
		--enable-slirp \
		`use_enable sdl`\
		|| die "could not configure"
	make || die "make failed"
}

src_install() {
	make install \
		prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share/qemu \
		docdir=${D}/usr/share/doc \
		mandir=${D}/usr/share/man || die
}

pkg_postinst() {
	einfo "You will need the Universal TUN/TAP driver compiled into"
	einfo "kernel or as a module to use the virtual network device."
	use softmmu || \
	(
	ewarn "You have the softmmu useflag disabled."
	ewarn "In order to have the full system emulator (qemu) you have"
	ewarn "to emerge qemu again with the softmmu useflag enabled"
	)
}
