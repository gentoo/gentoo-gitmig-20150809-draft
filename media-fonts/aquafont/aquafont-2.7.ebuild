# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/aquafont/aquafont-2.7.ebuild,v 1.4 2003/10/11 07:43:54 usata Exp $

IUSE=""
MY_P="${PN/font/}${PV/\./_}"

DESCRIPTION="Very pretty truetype font"
HOMEPAGE="http://aquablue.milkcafe.to/"
SRC_URI="http://aquablue.milkcafe.to/fnt/${MY_P}.lzh"

KEYWORDS="x86 alpha sparc ppc"
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
