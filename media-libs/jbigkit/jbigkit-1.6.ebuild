# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jbigkit/jbigkit-1.6.ebuild,v 1.4 2007/07/12 08:53:33 uberlord Exp $

inherit eutils

DESCRIPTION="highly effective data compression algorithm for bi-level high-resolution images such as fax pages or scanned documents"
HOMEPAGE="http://www.cl.cam.ac.uk/~mgk25/jbigkit/"
SRC_URI="http://www.cl.cam.ac.uk/~mgk25/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~sparc-fbsd ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	dobin pbmtools/jbgtopbm pbmtools/pbmtojbg || die "dobin"
	doman pbmtools/jbgtopbm.1 pbmtools/pbmtojbg.1

	insinto /usr/include
	newins libjbig/jbig.h jbig.h || die "doins include"
	dolib libjbig/libjbig.a || die "dolib"

	dodoc ANNOUNCE CHANGES INSTALL TODO
}
