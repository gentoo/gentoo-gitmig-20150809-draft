# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-0.5.3.ebuild,v 1.6 2004/06/27 23:06:17 vapier Exp $

DESCRIPTION="Multi-platform & multi-targets dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://fabrice.bellard.free.fr/qemu/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc -alpha -sparc"
IUSE=""
RESTRICT="nostrip"

DEPEND="virtual/libc
	media-libs/libsdl"
RDEPEND=""

TARGET_LIST="arm-user i386-user ppc-user sparc-user" #i386-softmmu

#RUNTIME_PATH="/emul/gnemul/"

src_compile() {
#		--interp-prefix=${RUNTIME_PATH}/qemu-%M
	./configure \
		--prefix=/usr \
		--target-list="${TARGET_LIST}" \
		|| die "could not configure"
	make || die "make failed"
}

src_install() {
	make install prefix=${D}/usr		\
		bindir=${D}/usr/bin				\
		sharedir=${D}/usr/share/qemu	\
		mandir=${D}/usr/share/man || die
}

pkg_postinst() {
	echo ">> You will need the Universal TUN/TAP driver compiled into"
	echo ">> kernel or as a module to use the virtual network device."
}
