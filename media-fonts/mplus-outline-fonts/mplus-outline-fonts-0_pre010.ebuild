# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mplus-outline-fonts/mplus-outline-fonts-0_pre010.ebuild,v 1.3 2006/01/12 00:47:52 robbat2 Exp $

inherit font

IUSE=""

MY_P="mplus-${PV/0_pre/TESTFLIGHT-}"
MY_IPAFONT="opfc-ModuleHP-1.1.1_withIPAFonts"

DESCRIPTION="M+ Japanese outline fonts with IPA font"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/
	https://sourceforge.jp/projects/opfc/"
SRC_URI="http://downloads.sourceforge.jp/mplus-fonts/6650/${MY_P}.tar.gz
	mirror://sourceforge.jp/opfc/13897/${MY_IPAFONT}.tar.gz"

RESTRICT="nomirror"

LICENSE="as-is grass-ipafonts"
SLOT="0"
KEYWORDS="~hppa ~ppc ~x86"

DEPEND="dev-lang/perl
	media-gfx/fontforge"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="LICENSE* README_J"

src_unpack() {
	unpack ${A}
	cp -p ${WORKDIR}/${MY_IPAFONT}/fonts/* ${S}
}

src_compile() {
	fontforge -script m++ipa.pe || die
	rm -f ipa* || die
}
