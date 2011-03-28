# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pinger/pinger-0.32.ebuild,v 1.5 2011/03/28 21:15:43 radhermit Exp $

EAPI=2

DESCRIPTION="Cyclic multi ping utility for selected adresses using GTK/ncurses."
HOMEPAGE="http://aa.vslib.cz/silk/projekty/pinger/index.php"
SRC_URI="http://aa.vslib.cz/silk/projekty/pinger/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4:2
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
