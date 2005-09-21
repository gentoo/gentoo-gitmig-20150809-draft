# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/spacetripper-demo/spacetripper-demo-1.ebuild,v 1.6 2005/09/21 20:27:11 wolf31o2 Exp $

inherit eutils games

MY_P="spacetripperdemo"
DESCRIPTION="hardcore arcade shoot-em-up"
HOMEPAGE="http://www.pompom.org.uk/"
SRC_URI="http://www.btinternet.com/%7Ebongpig/${MY_P}.sh"

LICENSE="POMPOM"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

S=${WORKDIR}

pkg_setup() {
	check_license POMPOM
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	exeinto "${dir}"
	doexe bin/x86/*
	sed -i \
		-e "s:XYZZY:${dir}:" "${Ddir}/${MY_P}" \
		|| die "sed failed"

	insinto "${dir}"
	doins -r preview run styles || die "doins failed"
	doins README license.txt icon.xpm

	dodir "${GAMES_BINDIR}"
	dosym "${dir}/${MY_P}" "${GAMES_BINDIR}/${PN}"

	prepgamesdirs
}
