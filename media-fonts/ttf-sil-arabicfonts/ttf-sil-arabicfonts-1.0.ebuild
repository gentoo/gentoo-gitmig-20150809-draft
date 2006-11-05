# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-arabicfonts/ttf-sil-arabicfonts-1.0.ebuild,v 1.4 2006/11/05 13:52:30 fmccor Exp $

inherit font versionator

DESCRIPTION="Arabic Script Unicode Fonts"
HOMEPAGE="http://scripts.sil.org/ArabicFonts"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="SIL-freeware"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc"
IUSE="X doc"

DOCS=""
FONT_SUFFIX="ttf"

FONT_S="${S}"

src_install() {
	font_src_install
	if use doc ; then
		insinto /usr/share/doc/${PN}-${PVR}
		doins *.pdf
	fi
}
