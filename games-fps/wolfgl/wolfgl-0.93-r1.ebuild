# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/wolfgl/wolfgl-0.93-r1.ebuild,v 1.9 2006/12/05 18:11:54 wolf31o2 Exp $

#ECVS_SERVER="wolfgl.cvs.sourceforge.net:/cvsroot/wolfgl"
#ECVS_MODULE="wolfgl"
#inherit cvs
inherit eutils games

DESCRIPTION="Wolfenstein and Spear of Destiny port using OpenGL"
HOMEPAGE="http://wolfgl.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tbz2
	mirror://sourceforge/wolfgl/wolfdata.zip
	mirror://sourceforge/wolfgl/sdmdata.zip"
#	mirror://sourceforge/wolfgl/wolfglx-wl6-${PV}.zip
#	mirror://sourceforge/wolfgl/wolfglx-sod-${PV}.zip

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}
	x11-proto/xproto
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc.patch \
		"${FILESDIR}"/${PV}-sample-rate.patch \
		"${FILESDIR}"/${PV}-sprite.patch \
		"${FILESDIR}"/${PV}-gcc4.patch
}

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" DATADIR="${GAMES_DATADIR}"/${PN} \
		|| die "emake failed"
}

src_install() {
	newgamesbin linux/SDM/wolfgl wolfgl-sdm || die
	newgamesbin linux/SOD/wolfgl wolfgl-sod || die
	newgamesbin linux/WL1/wolfgl wolfgl-wl1 || die
	newgamesbin linux/WL6/wolfgl wolfgl-wl6 || die
	insinto "${GAMES_DATADIR}"/${PN}
	doins "${WORKDIR}"/*.{sdm,wl1} || die
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "This installed the shareware data files for"
	einfo "Wolfenstein 3D and Spear Of Destiny."
	einfo "If you wish to play the full versions just"
	einfo "copy the data files to ${GAMES_DATADIR}/${PN}/"
}
