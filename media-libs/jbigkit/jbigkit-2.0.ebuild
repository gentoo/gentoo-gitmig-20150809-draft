# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jbigkit/jbigkit-2.0.ebuild,v 1.3 2010/02/28 11:53:41 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="data compression algorithm for bi-level high-resolution images"
HOMEPAGE="http://www.cl.cam.ac.uk/~mgk25/jbigkit/"
SRC_URI="http://www.cl.cam.ac.uk/~mgk25/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	tc-export AR CC RANLIB
	emake || die
}

src_test() {
	LD_LIBRARY_PATH=${S}/libjbig make test || die
}

src_install() {
	dobin pbmtools/jbgtopbm{,85} pbmtools/pbmtojbg{,85} || die
	doman pbmtools/jbgtopbm.1 pbmtools/pbmtojbg.1

	insinto /usr/include
	doins libjbig/*.h || die
	dolib libjbig/libjbig{,85}{.a,$(get_libname)} || die

	dodoc ANNOUNCE CHANGES TODO libjbig/*.txt
}
