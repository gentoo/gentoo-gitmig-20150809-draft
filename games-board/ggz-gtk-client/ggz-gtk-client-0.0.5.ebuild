# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.5.ebuild,v 1.2 2004/02/29 10:12:30 vapier Exp $

DESCRIPTION="The gtk client for GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="~dev-games/ggz-client-libs-0.0.5
	=x11-libs/gtk+-1.2*"

src_install() {
	make DESTDIR=${D} install || die
}
