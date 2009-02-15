# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/world-of-goo-demo/world-of-goo-demo-1.40.ebuild,v 1.1 2009/02/15 00:00:37 vapier Exp $

inherit games

MY_PN="WorldOfGooDemo"
DESCRIPTION="World of Goo is a puzzle game with a strong emphasis on physics"
HOMEPAGE="http://2dboy.com/"
SRC_URI="${MY_PN}.${PV}.tar.gz"

LICENSE="2dboy-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

# the package includes SDL/ogg/vorbis already
RDEPEND="sys-libs/glibc
	virtual/opengl
	virtual/glu
	>=sys-devel/gcc-3.4
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
	)"
DEPEND=""

S=${WORKDIR}/${MY_PN}

QA_EXECSTACK="opt/WorldOfGooDemo/WorldOfGoo.bin"

pkg_nofetch() {
	elog "To download the demo, visit http://worldofgoo.com/dl2.php?lk=demo"
	elog "and download ${A} and place it in ${DISTDIR}"
}

src_install() {
	local d="/opt/${MY_PN}"
	insinto ${d}
	doins -r */ ${MY_PN%Demo}* || die

	dodoc readme.html linux-issues.txt
	newicon icon.png ${MY_PN}.png
	make_desktop_entry ${MY_PN} "World Of Goo (Demo)" ${MY_PN}.png

	dosym ${d}/${MY_PN%Demo} "${GAMES_BINDIR}"/${MY_PN}
	pushd "${D}"${d} >/dev/null
	chmod a+rx ${MY_PN%Demo}* libs/lib* || die
	games_make_wrapper ${MY_PN} ${d}/${MY_PN%Demo}
	popd >/dev/null

	prepgamesdirs ${d}
}
