# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/palo/palo-1.2_pre20030115.ebuild,v 1.5 2003/02/27 16:41:16 gmsoft Exp $

DESCRIPTION="PALO : PArisc Linux Loader"
HOMEPAGE="http://parisc-linux.org/"
SRC_URI="http://ftp.parisc-linux.org/cvs/palo-1.2-CVS20030115.tar.gz"
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/palo

#Compile only on hppa stations
KEYWORDS="hppa -x86 -ppc -sparc -alpha -mips"
IUSE=""

PROVIDE="virtual/bootloader"

DEPEND=">=glibc-2.2.4"

src_compile() {
	make MACHINE=parisc iplboot
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	install -o root -g root -m644 -D  ${FILESDIR}/palo.conf ${D}/etc/palo.conf
}
