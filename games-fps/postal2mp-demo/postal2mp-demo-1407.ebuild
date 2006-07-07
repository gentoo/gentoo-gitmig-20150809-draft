# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/postal2mp-demo/postal2mp-demo-1407.ebuild,v 1.4 2006/07/07 19:23:39 augustus Exp $

inherit eutils games

DESCRIPTION="You play the Postal Dude: POSTAL 2 is only as violent as you are."
HOMEPAGE="http://www.gopostal.com/home/"
SRC_URI="mirror://3dgamers/postal2/Missions/postal2mpdemo-lnx-${PV}.tar.bz2"

LICENSE="postal2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="|| ( x11-libs/libXext
			  virtual/x11 )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			>=media-video/nvidia-glx-1.0.6629-r3
			x11-drivers/nvidia-drivers
			x11-drivers/nvidia-legacy-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"

S="${WORKDIR}"

GAMES_CHECK_LICENSE="yes"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

src_unpack() {
	unpack ${A}
	unpack_makeself postal2mpdemo-lnx-${PV}.run
	rm postal2mpdemo-lnx-${PV}.run
	dodir ${dir}
	tar -xf postal2mpdemo.tar -C ${Ddir}/ || die "failed unpacking postal2mpdemo.tar"
	tar -xf linux-specific.tar -C ${Ddir}/ || die "failed unpacking linux-specific.tar"
}

src_install() {
	insinto ${dir}
	doins README.linux postal2mpdemo.xpm postal2mpdemo_eula.txt

	exeinto ${dir}
	doexe bin/postal2mpdemo || die "doexe failed"
	dodir "${GAMES_BINDIR}"
	dosym "${dir}/postal2mpdemo" "${GAMES_BINDIR}/postal2mp-demo"

	newicon postal2mpdemo.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Postal 2: Share the Pain (Demo)" ${PN}.xpm

	prepgamesdirs
}
