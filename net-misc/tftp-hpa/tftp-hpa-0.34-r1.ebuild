# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tftp-hpa/tftp-hpa-0.34-r1.ebuild,v 1.4 2004/03/22 04:33:29 weeve Exp $

DESCRIPTION="port of the OpenBSD TFTP server"
SRC_URI="mirror://kernel/software/network/tftp/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc sparc x86"

DEPEND="virtual/glibc
	!virtual/tftp"

PROVIDE="virtual/tftp"

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc README* CHANGES INSTALL*

	insinto /etc/conf.d
	newins ${FILESDIR}/in.tftpd.confd in.tftpd
	exeinto /etc/init.d
	newexe ${FILESDIR}/in.tftpd.rc6 in.tftpd
}
