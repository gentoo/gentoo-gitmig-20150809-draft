# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wormux/wormux-0.5.1.ebuild,v 1.4 2006/04/24 19:02:24 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A free Worms clone"
HOMEPAGE="http://www.wormux.org/"
SRC_URI="http://download.gna.org/wormux/${PN}-src-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="nls debug"

RDEPEND=">=dev-games/clanlib-0.7
	=dev-cpp/libxmlpp-1*"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch

	if use nls ; then
		sed -i \
			-e '/^localedir =/s:=.*:=/usr/share/locale:' \
			po/Makefile.in || die "sed localedir"
	fi
}

src_compile() {
	egamesconf \
		$(use_enable nls) \
		$(use_enable debug) \
		|| die "egamesconf"
	emake || die "emake"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS README
	prepgamesdirs
}
