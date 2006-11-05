# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-galatia/ttf-sil-galatia-2.01.ebuild,v 1.1 2006/11/05 00:03:27 joslwah Exp $

inherit font versionator

DESCRIPTION="The Galatia SIL Greek Unicode Fonts package"
HOMEPAGE="http://scripts.sil.org/SILgrkuni"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="SIL-freeware"
SLOT="0"
KEYWORDS="~ppc64"
IUSE="X doc"

DOCS="GalatiaTest.txt"
FONT_SUFFIX="ttf"

FONT_S="${S}"

src_install() {
	font_src_install
	if use doc ; then
		insinto /usr/share/doc/${PN}-${PVR}
		doins *.pdf
	fi
}
