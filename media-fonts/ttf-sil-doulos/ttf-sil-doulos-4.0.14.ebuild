# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-doulos/ttf-sil-doulos-4.0.14.ebuild,v 1.2 2006/11/05 02:35:12 tester Exp $

inherit font versionator

DESCRIPTION="Doulos Typeface"
HOMEPAGE="http://scripts.sil.org/DoulosSILfont"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
IUSE="X doc"

DOCS="FONTLOG.txt OFL.txt OFL-FAQ.txt README.txt"
FONT_SUFFIX="ttf"

FONT_S="${S}"

src_install() {
	font_src_install
	if use doc ; then
		insinto /usr/share/doc/${PN}-${PVR}
		doins *.pdf
	fi
}
