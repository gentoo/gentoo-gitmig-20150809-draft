# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfortune/wmfortune-0.241.ebuild,v 1.7 2004/07/22 12:50:00 s4t4n Exp $

IUSE=""
DESCRIPTION="dock-app that shows forune messages"
HOMEPAGE="http://www.dockapps.com/file.php/id/90"
SRC_URI="http://www.dockapps.com/download.php/id/128/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 amd64 ppc"

DEPEND="games-misc/fortune-mod
	virtual/x11"

src_compile() {
	emake OPTIMIZE="${CFLAGS}" || die
}

src_install()
{
	dobin wmfortune
	dodoc CHANGES README TODO
}
