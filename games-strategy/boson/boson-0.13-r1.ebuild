# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boson/boson-0.13-r1.ebuild,v 1.1 2008/06/02 22:09:29 loki_val Exp $

inherit eutils flag-o-matic kde-functions cmake-utils

MY_P=${PN}-all-${PV}
DESCRIPTION="real-time strategy game, with the feeling of Command&Conquer(tm)"
HOMEPAGE="http://boson.sourceforge.net/"
SRC_URI="mirror://sourceforge/boson/${MY_P}.tar.bz2
	mirror://gentoo/${P}-patches.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/openal"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6-r1
	app-text/docbook-to-man"

need-kde 3

S=${WORKDIR}/${MY_P}

DOCS="code/AUTHORS code/ChangeLog code/README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SOURCE="${WORKDIR}/${P}-patches"
	EPATCH_SUFFIX="patch"
	epatch
}

src_compile() {
	append-flags -fno-strict-aliasing
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	for sgmlman in "${WORKDIR}/${P}-patches"/man-pages/*.sgml; do
		docbook-to-man "${sgmlman}" > "${sgmlman%.sgml}".6 || die
		doman "${sgmlman%.sgml}".6 || die
	done
}
