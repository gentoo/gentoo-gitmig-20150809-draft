# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nload/nload-0.6.0.ebuild,v 1.6 2004/08/19 02:19:40 gustavoz Exp $

DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
SRC_URI="mirror://sourceforge/nload/${P}.tar.gz"
HOMEPAGE="http://roland-riegel.de/nload/index_en.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	econf || die "./configure failed"
	emake || die "compile failed"
}

src_install () {
	#make DESTDIR=${D} install
	einstall || die
	dodoc README INSTALL ChangeLog AUTHORS
}

