# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/afternoonstalker/afternoonstalker-1.1.2.ebuild,v 1.2 2009/09/19 10:30:00 maekke Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Clone of the 1981 Night Stalker video game by Mattel Electronics"
HOMEPAGE="http://perso.b2b2c.ca/sarrazip/dev/afternoonstalker.html"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-games/flatzebra-0.1.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
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

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
	prepgamesdirs
}
