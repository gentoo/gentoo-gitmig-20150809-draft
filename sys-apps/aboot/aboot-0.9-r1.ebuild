# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="Alpha Linux boot loader for srm"
SRC_URI="http://aboot.sourceforge.net/tarballs/aboot-0.9bpre.tar.bz2"
HOMEPAGE="http://aboot.sourceforge.net/"

KEYWORDS="alpha"
SLOT="0"
LICENSE="gpl-2"

DEPEND="virtual/glibc"

RDEPEND="virtual/glibc"


src_unpack() {

	unpack ${A}

	mv ${WORKDIR}/aboot-0.9bpre ${WORKDIR}/${P}
	
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:/usr/man:/usr/share/man:" Makefile.orig > Makefile
}

src_compile() {

	emake || die
}

src_install() {

	dodir /{boot,sbin,usr/share/man/man5}
	make \
		root=${D} \
		bindir=${D}/sbin \
		bootdir=${D}/boot \
		mandir=${D}/usr/share/man \
		install

	dodoc COPYING ChangeLog INSTALL README TODO aboot.conf

	dodir /etc	
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

