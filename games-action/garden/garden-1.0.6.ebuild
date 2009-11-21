# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/garden/garden-1.0.6.ebuild,v 1.3 2009/11/21 18:10:57 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Multiplatform vertical shoot-em-up with non-traditional elements"
HOMEPAGE="http://garden.sourceforge.net/"
SRC_URI="mirror://sourceforge/garden/garden_of_coloured_lights-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/allegro"

S=${WORKDIR}/garden_of_coloured_lights-${PV}

src_prepare() {
	sed -i \
		-e '/SUBDIRS/s:resources::' \
		Makefile.in \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	newicon resources/garden.svg "${PN}.svg"
	make_desktop_entry garden "Garden of coloured lights"
	prepgamesdirs
}
