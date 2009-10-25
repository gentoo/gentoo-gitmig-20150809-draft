# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/xe/xe-2.16.2.ebuild,v 1.3 2009/10/25 15:19:15 maekke Exp $

EAPI=2
inherit games

DESCRIPTION="a multi system emulator for many console and handheld video game systems"
HOMEPAGE="http://www.xe-emulator.com/"
SRC_URI="amd64? ( http://www.xe-emulator.com/files/${PN}-x86-64-bin.${PV}.tar.bz2 )
	x86? ( http://www.xe-emulator.com/files/${PN}-x86-32-bin.${PV}.tar.bz2 )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

RDEPEND="x11-libs/libXv
	x11-libs/libXinerama
	x11-libs/libXxf86vm
	sys-libs/zlib
	media-libs/alsa-lib
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	mv -v * ${P} || die
}

src_prepare() {
	sed -i \
		-e '/strip/d' \
		-e '/^CC/d' \
		-e '/CC/s/$/ $(LDFLAGS)/' \
		-e 's/@//' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	newgamesbin xe xe.bin || die "newgamesbin failed"
	newgamesbin "${FILESDIR}"/xe-${PV} xe || die "newgamesbin failed"
	sed -i \
		-e "s:GENTOODIR:$(games_get_libdir)/${PN}:" "${D}/${GAMES_BINDIR}/xe" \
		|| die "sed failed"
	insinto "$(games_get_libdir)"/${PN}
	doins -r modules/ rc/ || die "doins failed"
	keepdir "$(games_get_libdir)"/${PN}/bios
	dodoc README.txt
	dohtml manual.html
	prepgamesdirs
}
