# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86/memtest86-3.4.ebuild,v 1.3 2011/01/09 03:24:42 vapier Exp $

inherit mount-boot eutils

DESCRIPTION="A stand alone memory test for x86 computers"
HOMEPAGE="http://www.memtest86.com/"
SRC_URI="http://www.memtest86.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="serial"
RESTRICT="test"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm head.s || die

	epatch "${FILESDIR}"/${PN}-3.4-build.patch #66630
	epatch "${FILESDIR}"/${PN}-3.3-gnu-hash.patch

	if use serial ; then
		sed -i \
			-e '/^#define SERIAL_CONSOLE_DEFAULT/s:0:1:' \
			config.h \
			|| die "sed failed"
	fi
}

src_install() {
	insinto /boot/memtest86
	doins memtest.bin || die "doins failed"
	dodoc README README.build-process
}

pkg_postinst() {
	mount-boot_pkg_postinst
	einfo
	einfo "memtest.bin has been installed in /boot/memtest86/"
	einfo "You may wish to update your bootloader configs"
	einfo "by adding these lines:"
	einfo " - For grub: (replace '?' with correct numbers for your boot partition)"
	einfo "    > title=Memtest86"
	einfo "    > root (hd?,?)"
	einfo "    > kernel /boot/memtest86/memtest.bin"
	einfo " - For lilo:"
	einfo "    > image  = /boot/memtest86/memtest.bin"
	einfo "    > label  = Memtest86"
	einfo
}
