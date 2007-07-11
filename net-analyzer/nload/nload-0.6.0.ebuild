# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nload/nload-0.6.0.ebuild,v 1.11 2007/07/11 23:49:24 mr_bones_ Exp $

DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
SRC_URI="mirror://sourceforge/nload/${P}.tar.gz"
HOMEPAGE="http://roland-riegel.de/nload/index_en.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_install () {
	#make DESTDIR=${D} install
	einstall || die
	dodoc README INSTALL ChangeLog AUTHORS
}
