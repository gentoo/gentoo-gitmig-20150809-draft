# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/aboot/aboot-0.9-r1.ebuild,v 1.2 2004/04/02 01:28:49 vapier Exp $

DESCRIPTION="Alpha Linux boot loader for SRM"
HOMEPAGE="http://aboot.sourceforge.net/"
SRC_URI="http://aboot.sourceforge.net/tarballs/aboot-0.9bpre.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* alpha"

DEPEND="virtual/glibc"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/aboot-0.9bpre ${WORKDIR}/${P}
	cd ${S}
	sed -i "s:/usr/man:/usr/share/man:" Makefile || die
}

src_compile() {
	emake || die
}

src_install() {
	dodir /boot /sbin /usr/share/man/man5
	make \
		root=${D} \
		bindir=${D}/sbin \
		bootdir=${D}/boot \
		mandir=${D}/usr/share/man \
		install

	dodoc ChangeLog INSTALL README TODO aboot.conf

	insinto /etc
	newins ${FILESDIR}/aboot.conf aboot.conf.example
}

pkg_postinst() {
	einfo "To make aboot install a new bootloader on your harddisk follow"
	einfo "these steps:"
	einfo ""
	einfo " - edit the file /etc/aboot.conf"
	einfo " - cd /boot"
	einfo " - swriteboot -c2 /dev/sda bootlx"
	einfo " This will install a new bootsector on /dev/sda and aboot will"
	einfo " use the second partition on this device to lookup kernel and "
	einfo " initrd (as described in the aboot.conf file)"
	einfo ""
	einfo "IMPORTANT :"
	einfo ""
	einfo "The partition table of your boot device has to contain "
	einfo "a BSD-DISKLABEL and the first 12 megabytes of your boot device"
	einfo "must not be part of a partition as aboot will write its bootloader"
	einfo "in there and not as with most x86 bootloaders into the "
	einfo "master boot sector. If your partition table does not reflect this"
	einfo "you are going to destroy your installation !"
	einfo "Also note that aboot currently only supports ext2/3 partitions"
	einfo "to boot from."
}
