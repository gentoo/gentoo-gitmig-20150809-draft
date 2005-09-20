# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.9.ebuild,v 1.3 2005/09/20 14:52:59 wolf31o2 Exp $

inherit eutils

DESCRIPTION="The gtk client for GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="http://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="nls"

DEPEND=">=dev-games/ggz-client-libs-${PV}
	=x11-libs/gtk+-2* "

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-duplicate-prototypes.patch
	sed -i 's:dir=$(prefix):dir=$(DESTDIR)$(prefix):' po/Makefile.in
}

src_compile() {
	local myconf="--enable-gtk=gtk2"

	econf \
		--disable-debug \
		$(use_enable nls) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
}
