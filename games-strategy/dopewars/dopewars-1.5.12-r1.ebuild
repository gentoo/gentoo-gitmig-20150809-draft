# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dopewars/dopewars-1.5.12-r1.ebuild,v 1.3 2008/05/12 11:51:44 nixnut Exp $

inherit games

DESCRIPTION="Re-Write of the game Drug Wars"
HOMEPAGE="http://dopewars.sourceforge.net/"
SRC_URI="mirror://sourceforge/dopewars/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="nls ncurses gtk gnome esd sdl"

RDEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )
	esd? ( media-sound/esound )
	gtk? ( =x11-libs/gtk+-2* )
	dev-libs/glib
	nls? ( virtual/libintl )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-mixer
	)"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/priv_hiscore/ s:DPDATADIR:\"${GAMES_STATEDIR}\":" \
		-e "/\/doc\// s:DPDATADIR:\"/usr/share\":" \
		-e 's:index.html:html/index.html:' \
		src/dopewars.c \
		|| die "sed failed"
}

src_compile() {
	local myservconf

	if ! use gtk ; then
		myservconf="--disable-gui-client --disable-gui-server --disable-glibtest --disable-gtktest"
	fi

	egamesconf \
		--disable-dependency-tracking \
		$(use_enable ncurses curses-client) \
		$(use_enable nls) \
		$(use_with sdl) \
		$(use_with esd) \
		--enable-networking \
		--enable-plugins \
		${myservconf} \
			|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	dodir /usr/share
	cd "${D}/${GAMES_DATADIR}"
	use gnome && mv gnome "${D}/usr/share" || rm -rf gnome
	mv pixmaps "${D}/usr/share"
	dohtml -r doc/*/*
	rm -rf doc

	prepgamesdirs
}
