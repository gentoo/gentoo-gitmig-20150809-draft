# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ltris/ltris-1.0.11.ebuild,v 1.2 2005/11/12 06:59:07 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="very polished Tetris clone"
HOMEPAGE="http://lgames.sourceforge.net/"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="nls"

RDEPEND=">=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/autoconf )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	if use nls ; then
		sed -i \
			-e '/^localedir/s:$(datadir):/usr/share:' \
			po/Makefile.in.in \
			|| die "sed failed"
		sed -i \
			-e '/^localedir/s:$datadir:/usr/share:' \
			configure.in \
			|| die "sed failed"
		aclocal && automake -a -c && autoconf || die "autotools failed"
	fi
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-highscore-path="${GAMES_STATEDIR}" \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	newicon icons/ltris48.xpm ${PN}.xpm
	make_desktop_entry ltris LTris ${PN}.xpm
	prepgamesdirs
}
