# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/xmoto/xmoto-0.2.2-r1.ebuild,v 1.1 2006/12/16 08:51:12 nyhm Exp $

inherit eutils games

DESCRIPTION="A challenging 2D motocross platform game"
HOMEPAGE="http://xmoto.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-mixer
	net-misc/curl
	dev-lang/lua
	dev-games/ode
	virtual/opengl
	virtual/glu
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./*.gz

	sed -i 's:xmoto.free.fr:xmoto.tuxfamily.org:' src/WWW.h \
		|| die "sed WWW.h failed"

	sed -i 's:$(localedir):/usr/share/locale:' po/Makefile.in.in \
		|| die "sed Makefile.in.in failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-localesdir=/usr/share/locale \
		$(use_enable nls) \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doman xmoto{,-edit}.6
	dodoc README TODO ChangeLog

	doicon extra/xmoto.xpm
	domenu extra/xmoto{,-edit}.desktop

	prepgamesdirs
}
