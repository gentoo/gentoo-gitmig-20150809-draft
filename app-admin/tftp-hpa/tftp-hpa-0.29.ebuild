# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tftp-hpa/tftp-hpa-0.29.ebuild,v 1.13 2003/04/23 14:20:36 vapier Exp $

DESCRIPTION="port of the OpenBSD TFTP server"
SRC_URI="ftp://ftp.kernel.org/pub/software/network/tftp/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	make || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc README* CHANGES INSTALL*

	insinto /etc/conf.d
	newins ${FILESDIR}/in.tftpd.confd in.tftpd
	exeinto /etc/init.d
	newexe ${FILESDIR}/in.tftpd.rc6 in.tftpd
}
