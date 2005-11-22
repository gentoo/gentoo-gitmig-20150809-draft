# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/coldwar-demo/coldwar-demo-1.ebuild,v 1.1 2005/11/22 15:32:53 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Third-person sneaker like Splinter Cell"
HOMEPAGE="http://www.coldwar-game.com/"

SRC_URI="coldwar_demo.run"
DOWNLOAD_URL="http://www.mindwarestudios.com/download/coldwar_demo.torrent"

# Not sure where the license is!
LICENSE="as-is"

SLOT="0"

# Has an "x86_64" dir, so maybe works on other arches (untested).
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip fetch"

DEPEND="app-arch/tar
	app-arch/gzip"

RDEPEND="virtual/x11
	virtual/opengl
	amd64? ( app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-medialibs
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download ${A} into ${DISTDIR}"
	einfo "using ${DOWNLOAD_URL}"
}

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
}

src_install() {
	mv bin/Linux/x86/glibc-2.1/bin/* bin/

	games_make_wrapper ${PN} ./bin/launcher "${dir}" "${dir}"
	newicon coldwar.xpm ${PN}.xpm || die "copying icon"
	make_desktop_entry "${PN}" "Cold War Demo" "${PN}".xpm

	rm -rf coldwar_demo.run setup.* bin/Linux lib/libopenal*
	mkdir -p ${Ddir}
	cp -r * ${Ddir}/ || die "recursive copy failed"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "To play the game, run: ${PN}"
}
