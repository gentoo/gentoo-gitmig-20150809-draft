# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.14.1.ebuild,v 1.6 2004/02/03 11:12:28 mr_bones_ Exp $

inherit games

MY_P=${PN}-${PV/_/-}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="ftp://ftp.freeciv.org/freeciv/stable/${MY_P}.tar.bz2
	http://www.freeciv.org/ftp/contrib/sounds/sets/stdsounds2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"
IUSE="X Xaw3d gtk gtk2 sdl nls readline"

RDEPEND="
	X? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )
	readline ( sys-libs/readline )
	>=sys-devel/bison-1.35
	sys-libs/zlib
	>=media-libs/libsdl-1.1.4
	media-libs/sdl-mixer
	media-libs/sdl-image
	gtk? (
			gtk2? (
				>=x11-libs/gtk+-2.0.0
				>=dev-libs/glib-2.0.0
				>=dev-libs/atk-1.0.3
				>=x11-libs/pango-1.0.5
			)
			!gtk2? (
				=x11-libs/gtk+-1*
				>=dev-libs/glib-1.2.5
				>=media-libs/imlib-1.9.2
			)
			>=media-libs/libogg-1.0
			>=media-libs/libvorbis-1.0-r2
		)"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=sys-apps/sed-4"

src_compile() {
	local myclient="no"
	use X && myclient="xaw"
	use Xaw3d && myclient="xaw3d"
	if [ `use gtk` ] ; then
		use gtk2 \
			&& myclient="gtk-2.0" \
			|| myclient="gtk"
	fi
	egamesconf \
		--disable-dependency-tracking \
		--with-zlib \
		`use_with readline` \
		`use_enable nls` \
		--enable-client=${myclient} \
		|| die
	# Grrrr, the locale location is hard-coded in configure.in to be
	# '${prefix}/share/locale'.  That is so wrong. (Bug 40253)
	if use nls ; then
		sed -i \
			-e "/LOCALEDIR/ s:\".*:\"${GAMES_DATADIR}/locale\":" config.h \
				|| die "locale fixup failed"
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /usr/X11R6/lib/X11/app-defaults
	doins data/Freeciv || die "doins failed"

	dodoc ChangeLog INSTALL NEWS \
		doc/{BUGS,CodingStyle,HACKING,HOWTOPLAY,PEOPLE,README*,TODO} \
			|| die "dodoc failed"
	# install sounds
	cp -R ../stdsounds* "${D}${GAMES_DATADIR}/${PN}"
	prepgamesdirs
}
