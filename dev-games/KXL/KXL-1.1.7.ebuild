# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/KXL/KXL-1.1.7.ebuild,v 1.3 2004/03/26 10:28:35 mr_bones_ Exp $

DESCRIPTION="Development Library for making games for X"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa"
IUSE=""

DEPEND="virtual/x11"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
}
