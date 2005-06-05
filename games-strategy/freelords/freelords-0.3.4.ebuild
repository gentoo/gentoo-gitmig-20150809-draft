# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.3.4.ebuild,v 1.3 2005/06/05 11:27:06 hansmi Exp $

inherit eutils games

DESCRIPTION="Free Warlords clone"
HOMEPAGE="http://www.freelords.org/"
SRC_URI="mirror://sourceforge/freelords/${P}.tar.bz2"

KEYWORDS="ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

RDEPEND="dev-libs/expat
	>=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/freetype-2
	=media-libs/paragui-1.0*
	=dev-libs/libsigc++-1.2*"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/AM_GNU_GETTEXT_VERSION/s/13/12/' \
		configure.in \
		|| die "sed failed"
	sed -i \
		-e "s:/etc/freelordsrc:${GAMES_SYSCONFDIR}/freelordsrc:" src/main.cpp \
		|| die "sed src/main.cpp failed"
	sed -i \
		-e "s:\$(prefix)/share/locale:/usr/share/locale:" src/Makefile.in \
		|| die "sed src/Makefile.in failed"
	autoconf -f -v
	./autogen.sh
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-paraguitest \
		$(use_enable nls) \
		|| die
	emake \
		localedir="/usr/share/locale" \
		CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		localedir="/usr/share/locale" \
		install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog DEPENDENCIES HACKER NEWS README TODO \
		doc/[[:upper:]]*
	prepgamesdirs
}
