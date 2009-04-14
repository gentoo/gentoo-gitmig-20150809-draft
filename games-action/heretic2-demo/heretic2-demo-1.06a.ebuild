# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heretic2-demo/heretic2-demo-1.06a.ebuild,v 1.9 2009/04/14 07:24:29 mr_bones_ Exp $

inherit eutils multilib games

DESCRIPTION="Third-person classic magical action-adventure game"
HOMEPAGE="http://www.lokigames.com/products/heretic2/
	http://www.hereticii.com/"
SRC_URI="mirror://lokigames/loki_demos/${PN}.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"
PROPERTIES="interactive"
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/heretic2-demo/ref_glx.so"

DEPEND="games-util/loki_patch"
RDEPEND="x86? (
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXau
	x11-libs/libXdmcp )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	# Can ignore warning: "A lone zero block at 116240"
	unpack_makeself
}

src_install() {
	local demo="data/demos/heretic2_demo"
	local exe="heretic2_demo.x86"

	loki_patch patch.dat data/ || die "loki patch failed"

	# Remove bad opengl library
	rm -r "${demo}/gl_drivers/"

	# Change to safe default of 800x600 and option of normal opengl driver
	sed -i "${demo}"/base/default.cfg \
		-e "s:fullscreen \"1\":fullscreen \"1\"\nset vid_mode \"4\":" \
		-e "s:libGL:/usr/$(get_libdir)/libGL:" \
		|| die "sed failed"

	insinto "${dir}"
	exeinto "${dir}"
	doins -r "${demo}"/* || die "doins failed"
	doexe "${demo}/${exe}" || die "doexe failed"

	games_make_wrapper ${PN} "./${exe}" "${dir}" "${dir}"
	newicon "${demo}"/icon.xpm ${PN}.xpm || die "newicon failed"
	make_desktop_entry ${PN} "Heretic 2 (Demo)" ${PN}

	prepgamesdirs
}
