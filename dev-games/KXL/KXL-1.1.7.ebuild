# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/KXL/KXL-1.1.7.ebuild,v 1.6 2005/03/20 05:58:07 vapier Exp $

DESCRIPTION="Development Library for making games for X"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""

DEPEND="virtual/x11"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
}
