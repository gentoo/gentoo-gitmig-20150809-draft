# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jonathan Gonzalez <ciberscroll@uole.com>
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-0.8.ebuild,v 1.1 2002/05/06 00:45:18 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console CD Player"
SRC_URI="http://www.x-paste.de/files/${P}.tar.gz"
HOMEPAGE="http://www.x-paste.de/projects/index.php"

DEPEND="virtual/glibc"

src_compile () {
		make || die
}

src_install () {
		into /usr
		dobin cdplay
}

