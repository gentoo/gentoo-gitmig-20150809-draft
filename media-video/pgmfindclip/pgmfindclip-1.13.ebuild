# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pgmfindclip/pgmfindclip-1.13.ebuild,v 1.1 2004/10/06 20:36:02 trapni Exp $

DESCRIPTION="automatically find a clipping border for a sequence of pgm images"
SRC_URI="http://www.lallafa.de/bp/files/${P}.tgz"
HOMEPAGE="http://www.lallafa.de/bp/pgmfindclip.html"
DEPEND="virtual/glibc"
KEYWORDS="~x86"
LICENSE="GPL-1"
SLOT="0"
IUSE=""

MY_S=${WORKDIR}

src_compile () {
	cd ${MY_S} || die
	emake || die
}

src_install () {
	cd ${MY_S} || die
	dobin ${PN} || die
}
