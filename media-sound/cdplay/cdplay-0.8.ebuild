# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-0.8.ebuild,v 1.12 2005/03/30 16:32:35 hansmi Exp $

DESCRIPTION="Console CD Player"
SRC_URI="http://www.x-paste.de/files/${P}.tar.gz"
HOMEPAGE="http://www.x-paste.de/projects/index.php"

DEPEND="virtual/libc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="x86 ppc ~alpha"

src_compile () {
	make || die
}

src_install () {
	dobin cdplay

	dodoc CREDITS README
}
