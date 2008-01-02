# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/szip/szip-2.1.ebuild,v 1.2 2008/01/02 18:15:19 armin76 Exp $

inherit eutils

DESCRIPTION="Implementation of the extended-Rice lossless compression algorithm"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/doc_resource/SZIP/"
SRC_URI="ftp://ftp.hdfgroup.org/lib-external/${PN}/${PV}/${P}.tar.gz"
LICENSE="szip"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	# fix example with adding -lm
	cd "${S}"
	epatch "${FILESDIR}"/szip-2.0-example.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc RELEASE.txt || die
}
