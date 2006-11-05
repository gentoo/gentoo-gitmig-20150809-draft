# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-abyssinica/ttf-sil-abyssinica-1.0.ebuild,v 1.5 2006/11/05 19:48:14 jer Exp $

inherit font versionator

DESCRIPTION="Abyssinica Typeface"
HOMEPAGE="http://scripts.sil.org/AbyssinicaSIL"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc"
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
