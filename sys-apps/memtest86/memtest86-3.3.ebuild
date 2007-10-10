# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86/memtest86-3.3.ebuild,v 1.2 2007/10/10 05:41:10 opfer Exp $

inherit mount-boot eutils

DESCRIPTION="A stand alone memory test for x86 computers"
HOMEPAGE="http://www.memtest86.com/"
SRC_URI="http://www.memtest86.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="serial"
RESTRICT="test"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-3.2-solar.patch #66630
	epatch "${FILESDIR}"/${P}-funky-test.patch
	epatch "${FILESDIR}"/${P}-gnu-hash.patch

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
	einfo
	einfo "memtest.bin has been installed in /boot/memtest86/"
	einfo "You may wish to update your bootloader configs"
	einfo "by adding these lines:"
	einfo " - For grub:"
	einfo "    > title=Memtest86"

	# a little magic to make users' life as easy as possible ;)
	bootpart=0
	root="(hd0,0)"
	res=`grep /boot /etc/fstab | grep -v "^#" | awk '{print $1}' | grep '/dev/hd[a-z0-9]\+'`
	if [ -n "${res}" ] ; then
		bootpart=1
	else
		res=`grep -v '^#' /etc/fstab | grep -e '/dev/hd[a-z0-9]\+[[:space:]]\+\/[[:space:]]\+' | awk '{print $1}'`
	fi

	if [ -n "${res}" ] ; then
		root=`echo ${res} | grep -o '[a-z][0-9]' | tr -t a-z 0123456789 | sed -e 's/\([0-9]\)\([0-9]\)/\1 \2/' | awk '{print "(hd" $1 "," $2-1 ")" }'`
	fi

	einfo "    > root ${root}"
	if [ "${bootpart}" -eq 1 ] ; then
		einfo "    > kernel /memtest86/memtest.bin"
	else
		einfo "    > kernel /boot/memtest86/memtest.bin"
	fi

	einfo " - For lilo:"
	einfo "    > image  = /boot/memtest86/memtest.bin"
	einfo "    > label  = Memtest86"
	einfo
}
