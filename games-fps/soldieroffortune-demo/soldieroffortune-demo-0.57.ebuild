# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/soldieroffortune-demo/soldieroffortune-demo-0.57.ebuild,v 1.6 2009/04/14 07:29:04 mr_bones_ Exp $

inherit eutils games

MY_PN=${PN/soldieroffortune/sof}

DESCRIPTION="First-person shooter based on the mercenary trade"
HOMEPAGE="http://www.lokigames.com/products/sof/"
SRC_URI="mirror://lokigames/loki_demos/${MY_PN}.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"
PROPERTIES="interactive"

DEPEND="games-util/loki_patch"
RDEPEND="virtual/opengl
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp
		media-libs/libvorbis
		media-libs/libogg
		media-libs/smpeg )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-soundlibs )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
}

src_install() {
	local demo="data/demos/sof_demo"
	local exe="sof-bin.x86"

	loki_patch patch.dat data/ || die "loki patch failed"

	insinto "${dir}"
	exeinto "${dir}"
	doins -r "${demo}"/* || die "doins failed"
	doexe "${demo}/${exe}" || die "doexe failed"

	# Replace bad library
	use x86 && dosym /usr/lib/libSDL.so "${dir}"/libSDL-1.1.so.0
	use amd64 && dosym /emul/linux/x86/usr/lib/libSDL.so \
		"${dir}"/libSDL-1.1.so.0

	games_make_wrapper ${PN} "./${exe}" "${dir}" "${dir}"
	newicon "${demo}"/launch/box.png ${PN}.png || die
	make_desktop_entry ${PN} "Soldier of Fortune (Demo)"

	prepgamesdirs
}
