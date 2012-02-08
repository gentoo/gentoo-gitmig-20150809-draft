# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent3-demo/descent3-demo-1.4.0a.ebuild,v 1.11 2012/02/08 21:27:45 vapier Exp $

inherit eutils unpacker games

DESCRIPTION="Indoor/outdoor 3D combat with evil robotic mining spacecraft"
HOMEPAGE="http://www.lokigames.com/products/descent3/"
SRC_URI="mirror://lokigames/loki_demos/${PN}.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND="games-util/loki_patch"
RDEPEND="sys-libs/glibc
	virtual/opengl
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		=media-libs/libsdl-1.2* )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl
		>=sys-libs/lib-compat-loki-0.2 )"

S=${WORKDIR}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"
	local demo="data/demos/descent3_demo"
	local exe="descent3_demo.x86"

	loki_patch patch.dat data/ || die "loki patch failed"

	insinto "${dir}"
	exeinto "${dir}"
	doins -r "${demo}"/* || die "doins failed"
	doexe "${demo}/${exe}" || die "doexe failed"

	# Required directory
	keepdir "${dir}"/missions

	# Fix for 2.6 kernel crash
	cd "${Ddir}"
	ln -sf ppics.hog PPics.Hog

	games_make_wrapper ${PN} "./${exe}" "${dir}"
	newicon "${demo}"/launch/box.png ${PN}.png || die "newicon failed"
	make_desktop_entry ${PN} "Descent 3 (Demo)" ${PN}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the game run:"
	elog " descent3-demo"
	elog
	elog "If the game appears blank, then run it windowed with:"
	elog " descent3-demo -w"
	echo
}
