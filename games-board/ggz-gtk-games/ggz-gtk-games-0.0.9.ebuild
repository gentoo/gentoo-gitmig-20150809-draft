# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-games/ggz-gtk-games-0.0.9.ebuild,v 1.3 2005/09/20 14:54:05 wolf31o2 Exp $

DESCRIPTION="These are the gtk versions of the games made by GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="http://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=games-board/ggz-gtk-client-${PV}
	=x11-libs/gtk+-2*"

src_compile() {
	myconf="--enable-gtk2"

	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
}
