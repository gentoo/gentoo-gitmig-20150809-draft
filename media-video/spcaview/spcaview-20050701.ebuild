# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/spcaview/spcaview-20050701.ebuild,v 1.4 2005/12/11 01:08:04 vanquirius Exp $

DESCRIPTION="A webcam viewer for the spca5xx driver."
HOMEPAGE="http://mxhaard.free.fr/sview.html"
SRC_URI="http://mxhaard.free.fr/spca50x/Download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="media-libs/libsdl"
RDEPEND="${DEPEND}
	media-video/spca5xx"

src_install() {
	dodir usr/bin
	make BIN=${D}/usr/bin install || die
	dodoc README Changelog
}
