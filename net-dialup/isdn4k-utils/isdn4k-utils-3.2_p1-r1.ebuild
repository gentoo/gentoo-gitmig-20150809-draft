# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.2_p1-r1.ebuild,v 1.1 2002/12/16 23:01:16 drobbins Exp $

IUSE="mysql"

S=${WORKDIR}/${PN}
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/${PN}.v3.2p1.tar.bz2"
HOMEPAGE="http://www.isdn4linux.de/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=virtual/linux-sources-2.4
	>=sys-libs/ncurses-5.1
	>=sys-libs/gdbm-1.8.0
	mysql? ( >=dev-db/mysql-3.23.26 )
	>=dev-lang/tk-8.3"


src_unpack() {
	unpack ${PN}.v3.2p1.tar.bz2
	cd ${S}
	cp ${FILESDIR}/${P}.config .config
	#disabling device creation the easy way:
	echo "#!/bin/bash" > scripts/makedev.sh
	echo "true" >> scripts/makedev.sh
}

src_compile() {                           
	cd ${S}
	make subconfig || die
	make || die
}

src_install() {                   
  	cd ${S}
	dodir /dev
	dodir /usr/sbin
	dodir /usr/bin
	make DESTDIR=${D} install || die
  
	dodoc COPYING NEWS README Mini-FAQ/isdn-faq.txt
	mv ${D}/usr/doc/vbox ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/doc ${D}/dev
	cp -f ${FILESDIR}/local.start ${D}/usr/share/doc/${PF}/local.start
}

pkg_postinst() {
	einfo
	einfo "Please remember to edit your /etc/modules.autoload to load your ISDN kernel modules."
	einfo "Also make sure to edit the /etc/isdn/* files and configure them correctly. "
	einfo "In /usr/share/doc/${PF} you can find an local.start example, which shows how to"
	einfo "start some utils."
	einfo
}
