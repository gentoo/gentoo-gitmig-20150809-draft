# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pinger/pinger-0.32c.ebuild,v 1.1 2008/01/20 18:52:30 armin76 Exp $

DESCRIPTION="Cyclic multi ping utility for selected adresses using GTK/ncurses."
HOMEPAGE="http://aa.vslib.cz/silk/projekty/pinger/index.php"
SRC_URI="http://aa.vslib.cz/silk/projekty/pinger/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-util/pkgconfig-0.12
	>=x11-libs/gtk+-2.4.0
	sys-libs/ncurses"

src_install() {
	make install DESTDIR="${D}"
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
