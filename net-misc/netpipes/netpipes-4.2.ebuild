# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netpipes/netpipes-4.2.ebuild,v 1.1 2005/01/13 10:03:15 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="netpipes - a package to manipulate BSD TCP/IP stream sockets"
HOMEPAGE="http://web.purplefrog.com/~thoth/netpipes/"
SRC_URI="http://web.purplefrog.com/~thoth/netpipes/ftp/${P}-export.tar.gz"
LICENSE="GPL-2"

SLOT="0"
# theoretically you should be able to build netpipes on ANY architecture
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}

src_compile () {
	emake CC=$(tc-getCC) || die
}

src_install() {
	mkdir -p ${D}/usr/share/man || die
	emake INSTROOT=${D}/usr INSTMAN=${D}/usr/share/man install || die
}
