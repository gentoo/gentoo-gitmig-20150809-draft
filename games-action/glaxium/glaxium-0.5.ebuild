# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/glaxium/glaxium-0.5.ebuild,v 1.15 2006/09/26 19:40:46 nyhm Exp $

inherit eutils flag-o-matic toolchain-funcs games

DESCRIPTION="OpenGL-based space-ship shoot-em-up style game"
HOMEPAGE="http://xhosxe.free.fr/glaxium/"
SRC_URI="http://xhosxe.free.fr/glaxium/glaxium_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-mixer-1.2.4
	x11-libs/libXmu
	x11-libs/libXi
	virtual/opengl
	virtual/glu
	virtual/glut
	>=media-libs/libpng-1.0.0"

S=${WORKDIR}/${PN}_${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if has_version x11-drivers/nvidia-legacy-drivers || \
		has_version x11-drivers/nvidia-drivers
	then
		epatch "${FILESDIR}/${P}-glx.patch"
	fi
	epatch "${FILESDIR}/${PV}-rc.patch" \
		"${FILESDIR}/${P}-gcc41.patch"
}

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}"
	egamesinstall \
		exec_prefix="${D}/${GAMES_PREFIX}" \
		datadir="${D}/${GAMES_DATADIR_BASE}" \
		|| die
	dodoc README.txt CHANGES.txt
	prepgamesdirs
}
