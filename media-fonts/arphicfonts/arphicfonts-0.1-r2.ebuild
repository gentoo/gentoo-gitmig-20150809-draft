# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arphicfonts/arphicfonts-0.1-r2.ebuild,v 1.5 2004/08/03 17:04:19 usata Exp $

inherit font

IUSE="X"

DESCRIPTION="Chinese TrueType Arphic Fonts"
HOMEPAGE="http://www.arphic.com.tw/"
SRC_URI="ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz"

SLOT="0"
LICENSE="Arphic"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~mips ppc64"

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"

DEPEND="${RDEPEND}
	x11-misc/ttmkfdir"
RDEPEND="X? ( virtual/x11 )"
