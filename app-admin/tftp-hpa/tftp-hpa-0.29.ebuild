# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/tftp-hpa/tftp-hpa-0.29.ebuild,v 1.3 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HPA's TFTP Daemon is a port of the OpenBSD TFTP server"
SRC_URI="ftp://ftp.kernel.org/pub/software/network/tftp/${P}.tar.bz2"
SLOT="0"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"

DEPEND="virtual/glibc"

src_compile() {
    ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} || die
    make || die
}

src_install () {
    make INSTALLROOT=${D} install || die
    dodoc README* CHANGES INSTALL*

	insinto /etc/conf.d
	newins ${FILESDIR}/in.tftpd.confd in.tftpd
	exeinto /etc/init.d
	newexe ${FILESDIR}/in.tftpd.rc6 in.tftpd
}
