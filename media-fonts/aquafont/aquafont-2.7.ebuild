# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/aquafont/aquafont-2.7.ebuild,v 1.7 2004/08/03 16:58:40 usata Exp $

IUSE=""
MY_P="${PN/font/}${PV/\./_}"

DESCRIPTION="Handwritten Japanese fixed-width TrueType font"
HOMEPAGE="http://aquablue.milkcafe.to/"
SRC_URI="http://aquablue.milkcafe.to/fnt/${MY_P}.lzh"

KEYWORDS="x86 alpha sparc ppc ~amd64"
LICENSE="aquafont"
SLOT=0

S="${WORKDIR}/${MY_P}"
DEPEND="${RDEPEND}
	app-arch/lha"
RDEPEND="virtual/x11"

FONTDIR="/usr/share/fonts/ttf/ja/aqua"

src_unpack(){

	lha e ${DISTDIR}/${MY_P}.lzh
}

src_install(){

	insinto ${FONTDIR}
	doins ${PN}.ttf
	mkfontscale ${D}/${FONTDIR}
	newins ${D}/${FONTDIR}/fonts.scale fonts.dir

	dodoc readme.txt
}

pkg_postinst() {
	einfo
	einfo "You need to add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
}

pkg_postrm(){
	einfo
	einfo "You need to remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
}
