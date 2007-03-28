# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/afternoonstalker/afternoonstalker-1.1.1.ebuild,v 1.3 2007/03/28 01:43:06 mr_bones_ Exp $

inherit autotools eutils games

DESCRIPTION="Clone of the 1981 Night Stalker video game by Mattel Electronics"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/afternoonstalker.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	dev-games/flatzebra"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^pkgsounddir/ s:sounds.*:\$(PACKAGE)/sounds:" \
		-e "/^desktopentrydir/ s:=.*:=/usr/share/applications:" \
		-e "/^pixmapdir/ s:=.*:=/usr/share/pixmaps:" \
		src/Makefile.am \
		|| die "sed failed"
	sed -i \
		-e '/^docdir/d' \
		-e '/INSTALL/d' \
		-e '/COPYING/d' \
		Makefile.am \
		|| die "sed failed"
	AT_M4DIR=macros eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF} \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
	prepgamesdirs
}
