# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unfonts/unfonts-0.0.20040526.ebuild,v 1.2 2004/07/14 17:10:42 agriffis Exp $

inherit font

DESCRIPTION="Korean UnFonts"
HOMEPAGE="http://chem.skku.ac.kr/~wkpark/project/font/UnFonts"

UNFONTS="UnBatang.ttf
	UnBatangBold.ttf
	UnBom.ttf
	UnDotum.ttf
	UnDotumBold.ttf
	UnGraphic.ttf
	UnGungseo.ttf
	UnPen.ttf
	UnPenheulim.ttf
	UnPilgi.ttf
	UnPilgiBold.ttf
	UnShinmun.ttf
	UnYetgul.ttf"

SRC_URI="${UNFONTS//Un/${HOMEPAGE}/Un}"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S=${S}

src_unpack(){

	mkdir ${P}

	for X in ${UNFONTS};do

		if [ -f ${DISTDIR}/${X} ]
		then
			cp ${DISTDIR}/$X ${S} > /dev/null || die
		fi

	done

}
