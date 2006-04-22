# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86+/memtest86+-1.65.ebuild,v 1.2 2006/04/22 22:39:36 nelchael Exp $

inherit mount-boot eutils

DESCRIPTION="Memory tester based on memtest86"
HOMEPAGE="http://www.memtest.org/"
SRC_URI="http://www.memtest.org/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="serial"
RESTRICT="test"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.50-hardened.patch
	if use serial ; then
		sed -e 's/#define SERIAL_CONSOLE_DEFAULT 0/#define SERIAL_CONSOLE_DEFAULT 1/' -i config.h
	fi
}

src_compile() {
	emake || die
}

src_install() {
	insinto /boot/memtest86plus
	doins memtest.bin || die
	dodoc README README.build-process
}

pkg_postinst() {
	einfo
	einfo "memtest.bin has been installed in /boot/memtest86plus/"
	einfo "You may wish to update your bootloader configs"
	einfo "by adding these lines:"

	# a little magic to make users' life as easy as possible ;)
	local fstab=${ROOT}/etc/fstab
	local root="(hd0,0)"
	local res=$(awk '$2 == "/boot" {print $1}' "${fstab}")
	if [[ -z ${res} ]] ; then
		res=$(awk '$2 == "/" {print $1}' "${fstab}")
	fi
	if [[ -n ${res} ]] ; then
		# transform /dev/hd* magic into grub naming ...
		#        /dev/hda1   ->         a1          ->      01
		root=$(echo "${res}" | grep -o '[a-z][0-9]' | tr -t a-z 0123456789)
		root="(hd${root:0:1},$((${root:1:1}-1)))"
	fi
	einfo " - For grub:"
	einfo "    > title=Memtest86Plus"
	einfo "    > root ${root}"
	einfo "    > kernel /boot/memtest86plus/memtest.bin"

	einfo " - For lilo:"
	einfo "    > image  = /boot/memtest86plus/memtest.bin"
	einfo "    > label  = Memtest86Plus"
	einfo
}
