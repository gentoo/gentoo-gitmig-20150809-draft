# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iplog/iplog-2.2.3.ebuild,v 1.16 2005/01/29 05:12:51 dragonheart Exp $


DESCRIPTION="iplog is a TCP/IP traffic logger"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"
HOMEPAGE="http://ojnk.sourceforge.net/"

DEPEND="virtual/libpcap"

SLOT="0"
LICENSE="|| ( GPL-2 FDL-1.1 )"
KEYWORDS="x86 ppc sparc "
IUSE=""

src_compile() {

	econf || die
	make CFLAGS="${CFLAGS} -D_REENTRANT" all || die

}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	dodoc AUTHORS COPYING.* NEWS README TODO example-iplog.conf
}

