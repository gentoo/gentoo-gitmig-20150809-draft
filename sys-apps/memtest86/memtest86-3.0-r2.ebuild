# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86/memtest86-3.0-r2.ebuild,v 1.1 2004/02/01 20:57:14 spock Exp $

inherit mount-boot

IUSE="serial"
S=${WORKDIR}/${P}
DESCRIPTION="A stand alone memory test for x86 computers"
SRC_URI="http://www.memtest86.com/${P}.tar.gz"
HOMEPAGE="http://www.memtest86.com/"
KEYWORDS="~x86 ~amd64 -ppc -sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# a little fix to make gcc-3.3.x happy
	epatch ${FILESDIR}/memtest86-3.0.patch
	sed -e '/DISCARD/d' -i memtest_shared.lds

	if [ `use serial` ] ; then
		sed -e 's/#define SERIAL_CONSOLE_DEFAULT 0/#define SERIAL_CONSOLE_DEFAULT 1/' -i config.h
	fi
}

src_compile() {
	emake || die
}

src_install() {

	dodir /boot/memtest86
	cp memtest.bin ${D}/boot/memtest86/memtest.bin
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
	res=`cat /etc/fstab | grep /boot | grep -v "^#" | awk '{print $1}' | grep '/dev/hd[a-z0-9]\+'`
	if [ -n "${res}" ] ; then
		bootpart=1
	else
		res=`cat /etc/fstab | grep -v '^#' | grep -e '/dev/hd[a-z0-9]\+[[:space:]]\+\/[[:space:]]\+' | awk '{print $1}'`
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

