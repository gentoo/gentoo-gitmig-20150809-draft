# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-0.8.ebuild,v 1.3 2002/07/19 13:13:39 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console CD Player"
SRC_URI="http://www.x-paste.de/files/${P}.tar.gz"
HOMEPAGE="http://www.x-paste.de/projects/index.php"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile () {
	make || die
}

src_install () {
	into /usr
	dobin cdplay

	dodoc CREDITS README
}
