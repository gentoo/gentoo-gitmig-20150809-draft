# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.7.ebuild,v 1.6 2004/04/19 12:16:18 wolf31o2 Exp $

DESCRIPTION="The client libraries for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-games/libggz-0.0.7
	dev-libs/expat
	dev-libs/popt"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog HACKING NEWS Quick* README* TODO
}
