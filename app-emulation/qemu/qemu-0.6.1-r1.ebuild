# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-0.6.1-r1.ebuild,v 1.2 2004/11/28 15:25:36 lu_zero Exp $

inherit eutils

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://fabrice.bellard.free.fr/qemu/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc -alpha -sparc"
IUSE="softmmu sdl" # nptl qemu-fast nptlonly"
RESTRICT="nostrip"

DEPEND="virtual/libc
	sdl? ( media-libs/libsdl )
	app-text/texi2html"
RDEPEND=""

set_target_list() {
	TARGET_LIST="arm-user i386-user ppc-user sparc-user" #i386-softmmu ppc-softmmu
	use softmmu && TARGET_LIST="${TARGET_LIST} i386-softmmu ppc-softmmu"
#	use qemu-fast && \
#		if use nptl # && use nptlonly
#		then
#			ewarn "qemu-fast won't build with nptl, useflag disabled"
#		else
#			if use sdl ; then
#				ewarn "qemu-fast enabled beware you need every library that"
#				ewarn "qemu would link compiled static you may need to emerge"
#				ewarn "again alsa-lib and nas"
#			fi
#			TARGET_LIST="${TARGET_LIST} i386"
#		fi
	export TARGET_LIST
}

#RUNTIME_PATH="/emul/gnemul/"
src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-20041126.patch
	cd ${S}
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
		docdir=${D}/usr/share/doc/${P} \
		mandir=${D}/usr/share/man || die
	chmod -x ${D}/usr/share/man/*/*
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
