# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxpuck/tuxpuck-0.8.2-r1.ebuild,v 1.7 2011/08/02 18:12:45 zmedico Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Hover hockey"
HOMEPAGE="http://home.no.net/munsuun/tuxpuck/"
SRC_URI="http://home.no.net/munsuun/tuxpuck/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/libpng
	virtual/jpeg
	media-libs/libvorbis"
DEPEND="${RDEPEND}
	media-libs/freetype:2"

src_prepare() {
	# Bug #376741 - Make unpack call compatible with both
	# PMS and <sys-apps/portage-2.1.10.10.
	cd man || die
	unpack ./${PN}.6.gz
	cd .. || die
	sed -i \
		-e 's/-Werror//' \
		-e '/^CC/d' \
		Makefile \
		utils/Makefile \
		data/Makefile \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	emake -C utils || die
	# Note that the Makefiles for tuxpuck are buggy so -j1 is used.
	emake -j1 -C data || die
	emake || die
}

src_install() {
	dogamesbin tuxpuck || die "dogamesbin failed"
	doman man/tuxpuck.6
	dodoc *.txt
	doicon data/icons/${PN}.ico
	make_desktop_entry ${PN} "TuxPuck" /usr/share/pixmaps/${PN}.ico
	prepgamesdirs
}
