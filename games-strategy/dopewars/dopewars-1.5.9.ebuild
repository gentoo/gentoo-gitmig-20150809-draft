# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dopewars/dopewars-1.5.9.ebuild,v 1.7 2004/03/24 05:09:26 mr_bones_ Exp $

inherit games

DESCRIPTION="Re-Write of the game Drug Wars"
HOMEPAGE="http://dopewars.sourceforge.net/"
SRC_URI="mirror://sourceforge/dopewars/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="nls ncurses gtk gtk2 gnome esd sdl"

RDEPEND="virtual/glibc
	ncurses? ( >=sys-libs/ncurses-5.2 )
	esd? ( media-sound/esound )
	gtk? (
		|| (
			gtk2? ( =x11-libs/gtk+-2* )
			=x11-libs/gtk+-1.2*
		)
		dev-libs/glib
	)
	nls? ( sys-devel/gettext )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-mixer
	)"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/priv_hiscore/ s:DPDATADIR:\"${GAMES_STATEDIR}\":" \
		-e "/\/doc\// s:DPDATADIR:\"/usr/share\":" \
		-e 's:index.html:html/index.html:' \
			src/dopewars.c \
				|| die "sed src/dopewars.c failed"
}

src_compile() {
	local myservconf=""
	if [ `use gtk` ] ; then
		myservconf="--enable-gui-server `use_enable gtk2 glib2`"
	else
		myservconf="--disable-gui-client --disable-glibtest --disable-gtktest"
	fi

	egamesconf \
		--disable-dependency-tracking \
		`use_enable ncurses curses-client` \
		`use_enable nls` \
		`use_with sdl` \
		`use_with esd` \
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
	dodir "${GAMES_STATEDIR}" || die "dodir failed"
	mv dopewars.sco "${D}/${GAMES_STATEDIR}"
	fperms 664 "${GAMES_STATEDIR}/dopewars.sco" || die "fperms failed"

	prepgamesdirs
}
