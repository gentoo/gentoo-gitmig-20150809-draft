# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jbig2dec/jbig2dec-0.11-r1.ebuild,v 1.2 2012/02/10 07:41:16 ago Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A decoder implementation of the JBIG2 image compression format"
HOMEPAGE="http://jbig2dec.sourceforge.net/"
SRC_URI="http://ghostscript.com/~giles/jbig2/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc ~x86"
IUSE="png static-libs"

RDEPEND="png? ( >=media-libs/libpng-1.2:0 )"
DEPEND="${RDEPEND}"

RESTRICT="test"
#the test files are missing from the tarball, nothing is tested and the
#test function just returns error. permanently restricted, see bug 324275

DOCS="CHANGES README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with png libpng)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
