# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86+/memtest86+-1.55.ebuild,v 1.2 2005/03/29 17:41:00 spock Exp $

inherit mount-boot eutils

DESCRIPTION="Memory tester based on memtest86"
HOMEPAGE="http://www.memtest.org/"
SRC_URI="http://www.memtest.org/download/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="serial"
DEPEND="virtual/libc"
RESTRICT="maketest"

src_unpack() {
	unpack ${A}
	cd ${S}

	# send the DOS newlines where they belong - /dev/null ;>
	sed -e 's/\x0d//g' -i Makefile || die
	epatch "${FILESDIR}"/${PN}-1.50-hardened.patch
	if use serial ; then
		sed -e 's/#define SERIAL_CONSOLE_DEFAULT 0/#define SERIAL_CONSOLE_DEFAULT 1/' -i config.h
	fi
}

src_compile() {
	emake || die
}

src_install() {
	dodir /boot/memtest86plus
	cp memtest.bin ${D}/boot/memtest86plus/memtest.bin || die
	dodoc README README.build-process
}

pkg_postinst() {
	einfo
	einfo "memtest.bin has been installed in /boot/memtest86plus/"
	einfo "You may wish to update your bootloader configs"
	einfo "by adding these lines:"
	einfo " - For grub:"
	einfo "    > title=Memtest86Plus"

	# a little magic to make users' life as easy as possible ;)
	bootpart=0
	root="(hd0,0)"
	res=`grep /boot /etc/fstab | grep -v "^#" | awk '{print $1}' | grep '/dev/hd[a-z0-9]\+'`
	if [ -n "${res}" ] ; then
		bootpart=1
	else
		res=`grep -v '^#' /etc/fstab | grep -e '/dev/hd[a-z0-9]\+[[:space:]]\+\/[[:space:]]\+' | \
			awk '{print $1}'`
	fi

	if [ -n "${res}" ] ; then
		root=`echo "${res}" | grep -o '[a-z][0-9]' | tr -t a-z 0123456789 | \
			  sed -e 's/\([0-9]\)\([0-9]\)/\1 \2/' | awk '{print "(hd" $1 "," $2-1 ")" }'`
	fi

	einfo "    > root ${root}"
	if [ "${bootpart}" -eq 1 ] ; then
		einfo "    > kernel /memtest86plus/memtest.bin"
	else
		einfo "    > kernel /boot/memtest86plus/memtest.bin"
	fi

	einfo " - For lilo:"
	einfo "    > image  = /boot/memtest86plus/memtest.bin"
	einfo "    > label  = Memtest86Plus"
	einfo
}
