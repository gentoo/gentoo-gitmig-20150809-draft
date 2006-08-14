# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mathematica-fonts/mathematica-fonts-5.2.ebuild,v 1.1 2006/08/14 15:47:20 foser Exp $

inherit font

DESCRIPTION="Mathematica's Fonts for MathML"

HOMEPAGE="http://support.wolfram.com/mathematica/systems/windows/general/latestfonts.html"
SRC_URI="http://support.wolfram.com/mathematica/systems/windows/general/files/MathFonts_${PV}.zip"

LICENSE="WRI-EULA"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"

RESTRICT="nomirror"
S=${WORKDIR}/

src_install() {

	FONT_S=${S}/Fonts/TrueType FONT_SUFFIX="ttf" font_src_install

	FONT_S=${S}/Fonts/Type1 FONT_SUFFIX="pfa" font_src_install

}

pkg_postinst() {

	einfo "To make Mozilla happy, you should change font.mathfont-family:"
	einfo "1. Enter the URL about:config"
	einfo "2. First, check to see if the pref exists"
	einfo "   If not, right-click and select New > String"
	einfo "   The name of the preference is font.mathfont-family"
	einfo "3. You should set the value to (right-click to modify):"
	einfo "   CMSY10, CMEX10, Mathematica1, Mathematica2, Mathematica4, MT Extra, Standard Symbols L"

}
