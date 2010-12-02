# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxtype/tuxtype-1.8.1.ebuild,v 1.2 2010/12/02 08:05:34 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Typing tutorial with lots of eye-candy"
HOMEPAGE="http://alioth.debian.org/projects/tux4kids/"
SRC_URI="http://alioth.debian.org/frs/download.php/3270/tuxtype_w_fonts-${PV}.tar.gz"

LICENSE="GPL-2 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-pango
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"

S=${WORKDIR}/tuxtype_w_fonts-${PV}

src_prepare() {
	sed -i \
		-e 's:$(prefix)/share:'${GAMES_DATADIR}':g' \
		-e 's:$(prefix)/doc/$(PACKAGE):/usr/share/doc/'${PF}':g' \
		$(find -name Makefile.in) || die "fixing Makefile paths"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
	rm -f "${D}"/usr/share/doc/${PF}/{COPYING,INSTALL}*
	doicon ${PN}.ico
	make_desktop_entry ${PN} TuxTyping /usr/share/pixmaps/${PN}.ico
	prepgamesdirs
}
