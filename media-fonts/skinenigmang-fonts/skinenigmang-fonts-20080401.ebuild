# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/skinenigmang-fonts/skinenigmang-fonts-20080401.ebuild,v 1.3 2008/04/07 18:43:28 zzam Exp $

S=${WORKDIR}/vdrsymbols

inherit font

DESCRIPTION="Font that contains symbols needed for VDR"

HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=74751"
SRC_URI="http://andreas.vdr-developer.org/enigmang/download/${P}.tgz"

LICENSE="BitstreamVera"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND=""

FONT_SUFFIX="ttf"

pkg_postinst() {
	font_pkg_postinst

	elog "To get nice symbols in VDR's OSD"
	elog "you need to select the font VDRSymbolsSans."
}

