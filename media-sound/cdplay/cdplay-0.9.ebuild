# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-0.9.ebuild,v 1.2 2003/11/12 06:11:48 vapier Exp $

DESCRIPTION="Console CD Player"
HOMEPAGE="http://www.x-paste.de/projects/index.php"
SRC_URI="http://www.x-paste.de/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND="virtual/glibc"

src_compile() {
	make || die
}

src_install() {
	dobin cdplay
	dodoc CREDITS README
}
