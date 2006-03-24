# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.9.ebuild,v 1.4 2006/03/24 16:30:44 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="The gtk client for GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="http://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="nls"

DEPEND="~dev-games/ggz-client-libs-${PV}
	=x11-libs/gtk+-2* "

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-duplicate-prototypes.patch
	sed -i 's:dir=$(prefix):dir=$(DESTDIR)$(prefix):' po/Makefile.in
}

src_compile() {
	egamesconf \
		--disable-debug \
		$(use_enable nls) \
		--enable-gtk=gtk2 \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
	prepgamesdirs
}
