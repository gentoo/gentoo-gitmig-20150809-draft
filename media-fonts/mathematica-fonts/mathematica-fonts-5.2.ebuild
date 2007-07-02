# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mathematica-fonts/mathematica-fonts-5.2.ebuild,v 1.7 2007/07/02 15:05:36 peper Exp $

inherit font

DESCRIPTION="Mathematica's Fonts for MathML"

HOMEPAGE="http://support.wolfram.com/mathematica/systems/windows/general/latestfonts.html"
SRC_URI="http://support.wolfram.com/mathematica/systems/windows/general/files/MathFonts_${PV}.zip"

LICENSE="WRI-EULA"

SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""
DEPEND="app-arch/unzip"

RESTRICT="mirror"
S=${WORKDIR}/

src_install() {

	FONT_S=${S}/Fonts/TrueType FONT_SUFFIX="ttf" font_src_install

	FONT_S=${S}/Fonts/Type1 FONT_SUFFIX="pfa" font_src_install

}

pkg_postinst() {

	elog "To make Mozilla happy, you should change font.mathfont-family:"
	elog "1. Enter the URL about:config"
	elog "2. First, check to see if the pref exists"
	elog "   If not, right-click and select New > String"
	elog "   The name of the preference is font.mathfont-family"
	elog "3. You should set the value to (right-click to modify):"
	elog "   CMSY10, CMEX10, Mathematica1, Mathematica2, Mathematica4, MT Extra, Standard Symbols L"

}
