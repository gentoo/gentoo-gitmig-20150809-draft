# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-abyssinica/ttf-sil-abyssinica-1.0.ebuild,v 1.9 2007/03/25 22:20:21 armin76 Exp $

inherit font versionator

DESCRIPTION="Abyssinica Typeface"
HOMEPAGE="http://scripts.sil.org/AbyssinicaSIL"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
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
