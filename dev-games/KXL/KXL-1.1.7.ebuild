# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/KXL/KXL-1.1.7.ebuild,v 1.2 2004/01/28 06:50:16 vapier Exp $

DESCRIPTION="Development Library for making games for X"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa"

DEPEND="virtual/x11"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING README
}
