# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.14.1.ebuild,v 1.3 2004/01/06 22:15:13 mr_bones_ Exp $

inherit games

MY_P=${PN}-${PV/_/-}
DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="ftp://ftp.freeciv.org/freeciv/stable/${MY_P}.tar.bz2
	http://www.freeciv.org/ftp/contrib/sounds/sets/stdsounds2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="X Xaw3d gtk gtk2 sdl nls"

DEPEND=">=sys-devel/gettext-0.10.36
	>=sys-devel/autoconf-2.13
	>=sys-devel/automake-1.4
	>=sys-devel/bison-1.35
	sys-libs/zlib
	X? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )
	media-libs/sdl-mixer
	media-libs/sdl-image
	>=media-libs/libsdl-1.1.4
	gtk? (
			gtk2? (
				>=x11-libs/gtk+-2.0.0
				>=dev-libs/glib-2.0.0
				>=dev-libs/atk-1.0.3
				>=x11-libs/pango-1.0.5
			) : (
				=x11-libs/gtk+-1*
				>=dev-libs/glib-1.2.5
				>=media-libs/imlib-1.9.2
			)
			>=media-libs/libogg-1.0
			>=media-libs/libvorbis-1.0-r2
		)"

S="${WORKDIR}/${MY_P}"

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
		`use_enable nls` \
		--enable-client=${myclient} \
		|| die
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
