# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/tftp-hpa/tftp-hpa-0.33.ebuild,v 1.1 2004/12/09 20:56:37 squinky86 Exp $

IUSE=""
DESCRIPTION="port of the OpenBSD TFTP server"
SRC_URI="mirror://kernel/software/network/tftp/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/libc"

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
