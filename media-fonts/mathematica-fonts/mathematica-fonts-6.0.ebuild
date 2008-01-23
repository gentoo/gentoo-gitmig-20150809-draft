# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mathematica-fonts/mathematica-fonts-6.0.ebuild,v 1.2 2008/01/23 18:25:48 armin76 Exp $

inherit font

DESCRIPTION="Mathematica's Fonts for MathML"

HOMEPAGE="http://support.wolfram.com/mathematica/systems/windows/general/latestfonts.html"
SRC_URI="http://support.wolfram.com/mathematica/systems/windows/general/files/MathFonts_${PV}.zip"

LICENSE="WRI-EULA"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="app-arch/unzip"

# WRI reserves the right to control all distribution of the Mathematica fonts
# and does not, at this time, allow them to be widely distributed via any
# servers, archives, or non-WRI software products of any kind without express
# written consent of WRI. There are no restrictions on embedding the fonts in
# documents transmitted to service bureaus, publishers, or other users of WRI
# products. There are no restrictions on widely distributing metrics files
# generated from the Mathematica fonts.
#
#                                                       == RESTRICT="mirror"

RESTRICT="mirror strip binchecks"
S=${WORKDIR}/

src_install() {
	FONT_S="${S}"/Fonts/TrueType FONT_SUFFIX="ttf" font_src_install
	FONT_S="${S}"/Fonts/Type1 FONT_SUFFIX="pfa" font_src_install
}

pkg_postinst() {
	echo
	elog "To make Mozilla happy, you should change font.mathfont-family:"
	elog "1. Enter the URL about:config"
	elog "2. First, check to see if the pref exists"
	elog "   If not, right-click and select New > String"
	elog "   The name of the preference is font.mathfont-family"
	elog "3. You should set the value to (right-click to modify):"
	elog "   CMSY10, CMEX10, Mathematica1, Mathematica2, Mathematica4, MT Extra, Standard Symbols L"
	echo
}
