# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arphicfonts/arphicfonts-0.1-r2.ebuild,v 1.12 2005/04/03 05:31:43 j4rg0n Exp $

inherit font

DESCRIPTION="Chinese TrueType Arphic Fonts"
HOMEPAGE="http://www.arphic.com.tw/"
SRC_URI="ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~ppc-macos"
IUSE="X"

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"
