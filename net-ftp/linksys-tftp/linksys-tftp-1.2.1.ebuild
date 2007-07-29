# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/linksys-tftp/linksys-tftp-1.2.1.ebuild,v 1.3 2007/07/29 00:29:11 beandog Exp $

IUSE=""
DESCRIPTION="TFTP client suitable for uploading to the Linksys WRT54G Wireless Router"
HOMEPAGE="http://redsand.net/"
SRC_URI="http://redsand.net/code/linksys-tftp-${PV}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
DEPEND="sys-devel/gcc
	virtual/libc"

RDEPEND="virtual/libc"

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin/
	doexe linksys-tftp || die
	dodoc README
}
