# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmifinfo/wmifinfo-0.06.ebuild,v 1.1 2004/01/04 04:28:48 port001 Exp $

IUSE=""

DESCRIPTION="WindowMaker Interface Monitor (dockapp)"
HOMEPAGE="http://www.zevv.nl/wmifinfo/"
SRC_URI="http://www.zevv.nl/wmifinfo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11"

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin wmifinfo
	dodoc README Changelog
}
