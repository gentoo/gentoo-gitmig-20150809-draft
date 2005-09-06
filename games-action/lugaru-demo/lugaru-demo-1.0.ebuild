# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/lugaru-demo/lugaru-demo-1.0.ebuild,v 1.1 2005/09/06 02:33:12 vapier Exp $

inherit games

DESCRIPTION="3D arcade with unique fighting system and antropomorphic characters"
HOMEPAGE="http://wolfire.com/lugaru.html"
SRC_URI="http://www.wolfiles.com/lugaru-linux-x86-${PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/glibc"
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack_makeself lugaru-linux-x86-${PV}.run
	tar xpf lugaru-linux-x86.tar || die "executables unpacking failed"
	tar xpf lugaru-data.tar || die "data unpacking failed"
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/lugaru

	insinto "${dir}"
	doins -r Data Readme README.linux Screenshots Troubleshooting || die "doins"

	exeinto "${dir}"
	doexe lugaru-bin *.so *.so.0 || die "doexe"
	games_make_wrapper lugaru ./lugaru-bin "${dir}"

	doicon lugaru.xpm
	make_desktop_entry lugaru "Lugaru" lugaru.xpm

	prepgamesdirs
}
