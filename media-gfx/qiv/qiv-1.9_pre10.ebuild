# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-1.9_pre10.ebuild,v 1.5 2004/02/28 07:22:18 jhuebel Exp $

P="qiv-1.9-pre10"
S="${WORKDIR}/qiv-1.9"
DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.klografx.net/qiv/devel/${P}.tgz"
HOMEPAGE="http://www.klografx.net/qiv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

DEPEND="media-libs/libpng
	>=media-libs/tiff-3.5.5
	>=media-libs/imlib-1.9.10
	virtual/x11"

src_compile() {
	make || die
}

src_install () {
	into /usr
	dobin qiv
	doman qiv.1
	dodoc README*
}
