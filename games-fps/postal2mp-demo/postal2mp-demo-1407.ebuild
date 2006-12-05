# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/postal2mp-demo/postal2mp-demo-1407.ebuild,v 1.7 2006/12/05 17:16:17 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="You play the Postal Dude: POSTAL 2 is only as violent as you are."
HOMEPAGE="http://www.gopostal.com/home/"
SRC_URI="mirror://3dgamers/postal2/Missions/postal2mpdemo-lnx-${PV}.tar.bz2"

LICENSE="postal2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="x11-libs/libXext
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			x11-drivers/nvidia-legacy-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"
DEPEND=">=sys-apps/portage-2.1"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

src_unpack() {
	unpack ${A}
	unpack_makeself postal2mpdemo-lnx-${PV}.run
	rm -f postal2mpdemo-lnx-${PV}.run
	unpack ./postal2mpdemo.tar  && rm -f postal2mpdemo.tar
	unpack ./linux-specific.tar && rm -f linux-specific.tar
}

src_install() {
	insinto "${dir}"
	doins -r * || die

	games_make_wrapper ${PN} ./postal2-bin "${dir}"/System

	newicon postal2mpdemo.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Postal 2: Share the Pain (Demo)" ${PN}.xpm

	fperms 750 "${dir}"/System/{postal2,ucc}-bin
	prepgamesdirs
}
