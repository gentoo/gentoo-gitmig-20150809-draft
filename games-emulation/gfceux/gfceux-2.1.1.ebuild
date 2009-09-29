# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gfceux/gfceux-2.1.1.ebuild,v 1.1 2009/09/29 05:16:34 mr_bones_ Exp $

EAPI=2
inherit eutils distutils games

DESCRIPTION="A graphical frontend for the FCEUX emulator"
HOMEPAGE="http://fceux.com"
SRC_URI="mirror://sourceforge/fceultra/fceux-${PV}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	dev-python/pygtk"
RDEPEND="${DEPEND}
	games-emulation/fceux"

S=${WORKDIR}/${PN}

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	python_version
	distutils_src_compile
}

src_install() {
	distutils_src_install \
		--install-scripts="${GAMES_BINDIR}"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	distutils_pkg_postinst
}
