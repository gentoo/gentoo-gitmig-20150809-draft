# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pgmfindclip/pgmfindclip-1.13.ebuild,v 1.3 2005/07/28 10:45:13 dholm Exp $

IUSE=""

S="${WORKDIR}"

DESCRIPTION="automatically find a clipping border for a sequence of pgm images"
HOMEPAGE="http://www.lallafa.de/bp/pgmfindclip.html"
SRC_URI="http://www.lallafa.de/bp/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/libc"

src_compile () {
	emake || die
}

src_install () {
	dobin ${PN} || die
}
