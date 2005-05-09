# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/majesty-demo/majesty-demo-1.0.0.ebuild,v 1.2 2005/05/09 15:31:29 dholm Exp $

inherit eutils games

DESCRIPTION="Control your own kingdom in this simulation."
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=8&"
SRC_URI="http://demos.linuxgamepublishing.com/majesty/majesty_demo.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="virtual/x11"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodoc README* || die "dodoc"
	insinto ${dir}
	exeinto ${dir}
	doins -r data quests || die "doins data"
	doins majesty.{bmp,xpm} majestysite.url || die "doins"
	cp ${S}/majesty.xpm ${S}/majesty-demo.xpm || die "copy icon"
	doicon majesty-demo.xpm || die "doicon"
	# I am only installing the static version for now
	if use x86 || use amd64; then
		doexe bin/Linux/x86/glibc-2.1/maj_demo || die "doexe"
	elif use ppc; then
		doexe bin/Linux/ppc/glibc-2.1/maj_demo || die "doexe"
	fi
	games_make_wrapper maj_demo ./maj_demo ${dir}
	prepgamesdirs
	make_desktop_entry maj_demo "Majesty Demo" ${PN}.xpm
}
