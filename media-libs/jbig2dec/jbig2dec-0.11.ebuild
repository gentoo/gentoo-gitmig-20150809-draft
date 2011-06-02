# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jbig2dec/jbig2dec-0.11.ebuild,v 1.10 2011/06/02 15:21:19 mr_bones_ Exp $

EAPI=2

DESCRIPTION="A decoder implementation of the JBIG2 image compression format"
HOMEPAGE="http://jbig2dec.sourceforge.net/"
SRC_URI="http://ghostscript.com/~giles/jbig2/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="png static-libs"

DEPEND="png? ( >=media-libs/libpng-1.4 )"
RDEPEND=${DEPEND}

RESTRICT="test"
#the test files are missing from the tarball, nothing is tested and the
#test function just returns error. permanently restricted, see bug 324275

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_with png libpng)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGES README
	find "${D}" -name '*.la' -delete
}
