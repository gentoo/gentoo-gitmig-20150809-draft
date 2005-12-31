# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dopewars/dopewars-1.5.12.ebuild,v 1.1 2005/12/31 21:01:18 mr_bones_ Exp $

inherit games

DESCRIPTION="Re-Write of the game Drug Wars"
HOMEPAGE="http://dopewars.sourceforge.net/"
SRC_URI="mirror://sourceforge/dopewars/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls ncurses gtk gnome esd sdl"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )
	esd? ( media-sound/esound )
	gtk? (
		=x11-libs/gtk+-2*
		dev-libs/glib
	)
	nls? ( sys-devel/gettext )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-mixer
	)"

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

	if use gtk ; then
		myservconf="--enable-gui-server $(use_enable gtk glib2)"
	else
		myservconf="--disable-gui-client --disable-glibtest --disable-gtktest"
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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	cd "${D}/${GAMES_DATADIR}"
	use gnome && mv gnome ../ || rm -rf gnome
	mv pixmaps ../
	dohtml -r doc/*/*
	rm -rf doc

	prepgamesdirs
}
