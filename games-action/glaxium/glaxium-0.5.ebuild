# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/glaxium/glaxium-0.5.ebuild,v 1.14 2006/04/02 11:14:32 tupone Exp $

inherit eutils flag-o-matic toolchain-funcs games

DESCRIPTION="OpenGL-based space-ship shoot-em-up style game"
HOMEPAGE="http://xhosxe.free.fr/glaxium/"
SRC_URI="http://xhosxe.free.fr/glaxium/glaxium_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-mixer-1.2.4
	|| ( ( x11-libs/libXmu
			x11-libs/libXi )
		virtual/x11 )
	virtual/opengl
	virtual/glu
	virtual/glut
	>=media-libs/libpng-1.0.0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}_${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	has_version '>=media-video/nvidia-glx-1.0.5328' \
		&& epatch "${FILESDIR}/${P}-glx.patch"
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
