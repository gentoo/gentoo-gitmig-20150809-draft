# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.13.ebuild,v 1.2 2006/03/24 17:14:45 wolf31o2 Exp $

inherit games

DESCRIPTION="The gtk client for the GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="~dev-games/ggz-client-libs-0.0.13
	=x11-libs/gtk+-2*"

src_compile() {
	local myconf="--enable-gtk=gtk2"

	egamesconf \
		--enable-gtk=gtk2 \
		--disable-debug \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
	domenu ${D}/usr/share/games/applications/ggz-gtk.desktop
	rm -rf ${D}/usr/share/games
	prepgamesdirs
}

