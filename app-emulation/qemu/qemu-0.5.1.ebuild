# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-0.5.1.ebuild,v 1.2 2004/01/28 03:47:12 zul Exp $

DESCRIPTION="Multi-platform & multi-targets dynamic translator"
SRC_URI="http://fabrice.bellard.free.fr/qemu/qemu-0.5.1.tar.gz"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"

KEYWORDS="x86 ~ppc -alpha -sparc -arm"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
IUSE=""

DEPEND="virtual/glibc
		media-libs/libsdl"
RDEPEND=""

RESTRICT="nostrip"

TARGET_LIST="arm-user i386-user i386-softmmu ppc-user sparc-user"

src_compile () {
	./configure --prefix=/usr \
				--target-list="${TARGET_LIST}" || die "could not configure"
	make || die "make failed"
}

src_install() {
	dobin qemu-mkcow
	dodir /usr/share/qemu
	insinto /usr/share/qemu
	doins pc-bios/bios.bin pc-bios/vgabios.bin
	doman qemu.1

	dobin arm-user/qemu-arm
	dobin i386-user/qemu-i386
	dobin sparc-user/qemu-sparc
	dobin ppc-user/qemu-ppc
	dobin sparc-user/qemu-sparc

	dobin i386-softmmu/qemu

	dodoc README README.distrib *.html linux.sh
}

pkg_postinstall() {
	echo ">> You will need the Universal TUN/TAP driver compiled into"
	echo ">> kernel or as a module to use the virtual network device."
}
