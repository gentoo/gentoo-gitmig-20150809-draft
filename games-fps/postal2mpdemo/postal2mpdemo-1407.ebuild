# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/postal2mpdemo/postal2mpdemo-1407.ebuild,v 1.9 2005/01/20 23:07:26 vapier Exp $

inherit eutils games

DESCRIPTION="You play the Postal Dude: POSTAL 2 is only as violent as you are."
HOMEPAGE="http://www.gopostal.com/home/"
SRC_URI="mirror://3dgamers/pub/3dgamers/games/postal2/Missions/${PN}-lnx-${PV}.tar.bz2"

LICENSE="postal2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""
RESTRICT="nomirror"

RDEPEND="virtual/x11
	virtual/libc
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-nvidia
	)"

S="${WORKDIR}"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	unpack_makeself postal2mpdemo-lnx-${PV}.run
	rm postal2mpdemo-lnx-${PV}.run
}

src_install() {
	dodir ${dir}

	tar -xf postal2mpdemo.tar -C ${Ddir}/ || die "failed unpacking postal2mpdemo.tar"
	tar -xf linux-specific.tar -C ${Ddir}/ || die "failed unpacking linux-specific.tar"

	insinto ${dir}
	doins README.linux postal2mpdemo.xpm postal2mpdemo_eula.txt

	exeinto ${dir}
	doexe bin/postal2mpdemo || die "doexe failed"
	dodir "${GAMES_BINDIR}"
	dosym "${dir}/postal2mpdemo" "${GAMES_BINDIR}/postal2mpdemo"

	prepgamesdirs
}
