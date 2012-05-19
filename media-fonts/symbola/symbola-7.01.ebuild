# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/symbola/symbola-7.01.ebuild,v 1.2 2012/05/19 15:06:06 ago Exp $

EAPI=4

MY_PN="${PN/s/S}"

inherit font

DESCRIPTION="Unicode font for Basic Latin, IPA Extensions, Greek, Cyrillic and many Symbol Blocks"
HOMEPAGE="http://users.teilar.gr/~g1951d/"
SRC_URI="http://users.teilar.gr/~g1951d/${MY_PN}${PV/./}.zip"
LICENSE="as-is"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
FONT_SUFFIX="ttf"

pkg_setup() {
	if use doc; then
		DOCS=( ${MY_PN}.pdf )
	fi
}
