# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/blassic/blassic-0.7.1.ebuild,v 1.1 2003/09/08 02:48:36 msterret Exp $

DESCRIPTION="classic Basic interpreter"
HOMEPAGE="http://www.arrakis.es/~ninsesabe/blassic/index.html"
SRC_URI="http://www.arrakis.es/~ninsesabe/blassic/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa"
IUSE="svga"

DEPEND="virtual/x11
	sys-libs/ncurses
	svga? ( media-libs/svgalib )"

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README THANKS TODO
}
