# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/szip/szip-2.0.ebuild,v 1.1 2007/08/18 10:59:39 bicatali Exp $

inherit eutils

DESCRIPTION="Szip is an implementation of the extended-Rice lossless compression algorithm"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/doc_resource/SZIP/"
SRC_URI="ftp://ftp.hdfgroup.org/lib-external/${PN}/${PV}/src/${P}.tar.gz"
LICENSE="szip"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	# fix example with adding -lm
	cd "${S}"
	epatch "${FILESDIR}"/szip-2.0-example.patch
}

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc RELEASE.txt
}
