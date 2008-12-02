# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mathematica-fonts/mathematica-fonts-7.0.ebuild,v 1.1 2008/12/02 07:59:40 pva Exp $

inherit font

DESCRIPTION="Mathematica's Fonts for MathML"

HOMEPAGE="http://support.wolfram.com/technotes/latestfonts.en.html"
SRC_URI="http://download.wolfram.com/download/T6RFFB/MathematicaV7FontsLinux.tar.gz"

LICENSE="WRI-EULA"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RESTRICT="mirror strip binchecks"
S=${WORKDIR}

src_install() {
	FONT_S="${S}"/Fonts/TTF FONT_SUFFIX="ttf" font_src_install
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
