# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/ccze/ccze-0.2.1.ebuild,v 1.1 2003/06/26 11:29:55 joker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A flexible and fast logfile colorizer"
SRC_URI="ftp://bonehunter.rulez.org/pub/ccze/stable/${P}.tar.gz"
HOMEPAGE="http://bonehunter.rulez.org/CCZE.html"

DEPEND="virtual/glibc
        sys-libs/ncurses
	dev-libs/libpcre"

RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 sparc"
LICENSE="GPL-2"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	# einstall caused sandbox violations
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog ChangeLog-0.1 NEWS THANKS COPYING INSTALL README TODO
}
