# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-0.9-r1.ebuild,v 1.2 2005/09/14 07:07:46 agriffis Exp $

DESCRIPTION="Console CD Player"
HOMEPAGE="http://www.x-paste.de/projects/index.php"
SRC_URI="http://www.x-paste.de/files/${P}.tar.gz"

DEPEND="virtual/libc
	!media-sound/cdtool"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin cdplay
	dodoc CREDITS README
}
