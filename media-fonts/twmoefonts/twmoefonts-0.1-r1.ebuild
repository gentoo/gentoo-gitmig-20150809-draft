# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/twmoefonts/twmoefonts-0.1-r1.ebuild,v 1.4 2004/07/29 19:03:28 kugelfang Exp $

inherit font

IUSE=""

DESCRIPTION="Standard tranditional Chinese fonts made by Minister of Education (MOE), Republic of China."
SRC_URI="ftp://ftp.ncu.edu.tw/FreeBSD/distfiles/zh-moettf/moe_kai.ttf
	ftp://ftp.ncu.edu.tw/FreeBSD/distfiles/zh-moettf/moe_sung.ttf"
HOMEPAGE=""	# Unable to find homepage
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

FONT_SUFFIX="ttf"

src_unpack() {
	mkdir ${WORKDIR}/${P}
	cp ${DISTDIR}/moe_kai.ttf ${WORKDIR}/${P}/moe_kai.ttf
	cp ${DISTDIR}/moe_sung.ttf ${WORKDIR}/${P}/moe_sung.ttf
}
