# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.9.ebuild,v 1.1 2004/12/26 22:56:37 vapier Exp $

DESCRIPTION="The client libraries for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~sparc ~ppc ~x86"
IUSE=""

DEPEND=">=dev-games/libggz-${PV}
	dev-libs/expat
	dev-libs/popt"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog HACKING NEWS Quick* README* TODO
}
