# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-0.9.ebuild,v 1.9 2004/10/19 03:26:52 tgall Exp $

DESCRIPTION="Console CD Player"
HOMEPAGE="http://www.x-paste.de/projects/index.php"
SRC_URI="http://www.x-paste.de/files/${P}.tar.gz"

DEPEND="virtual/libc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="x86 ~ppc ~alpha sparc amd64 ppc64"

src_compile() {
	make || die
}

src_install() {
	dobin cdplay
	dodoc CREDITS README
}
