# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/phobiaii/phobiaii-1.1.ebuild,v 1.14 2007/03/12 20:08:26 nyhm Exp $

inherit eutils games

MY_P="linuxphobia-${PV}"
DESCRIPTION="Just a moment ago, you were safe inside your ship, behind five inch armour"
HOMEPAGE="http://www.lynxlabs.com/games/linuxphobia/index.html"
SRC_URI="http://www.lynxlabs.com/games/linuxphobia/${MY_P}-i386.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"

RDEPEND="media-libs/sdl-mixer
	media-libs/libsdl
	x86? ( sys-libs/lib-compat )
	amd64? ( app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}/${MY_P}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	games_make_wrapper phobiaII ./linuxphobia "${dir}"
	newicon phobia2.ico ${PN}.ico
	make_desktop_entry phobiaII "Phobia II" /usr/share/pixmaps/${PN}.ico
	insinto "${dir}"
	doins -r * || die "doins failed"
	rm -rf "${D}/${dir}"/{*.desktop,*.sh,/pics/.xvpics}
	fperms 750 "${dir}"/linuxphobia
	prepgamesdirs
}
