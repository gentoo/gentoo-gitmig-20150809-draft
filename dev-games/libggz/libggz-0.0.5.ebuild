# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.5.ebuild,v 1.3 2004/02/17 04:23:50 mr_bones_ Exp $

DESCRIPTION="The GGZ library, used by GGZ Gameing Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS Quick* README*
}
