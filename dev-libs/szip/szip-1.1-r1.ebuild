# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/szip/szip-1.1-r1.ebuild,v 1.4 2004/07/30 06:18:06 phosphan Exp $

inherit eutils

MY_P="${P/-}"

DESCRIPTION="Szip is an implementation of the extended-Rice lossless compression algorithm"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/doc_resource/SZIP/"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/szip/src/${MY_P}.tar.gz"
LICENSE="szip"

SLOT="0"
KEYWORDS="x86 amd64 ppc"

IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	./configure -s --prefix="/usr" || die
	emake CFLAGS="${CFLAGS} -DHAVE_UNISTD_H -DUSE_MMAP" || die
}

src_install() {
	dodir /usr/include
	dodir /usr/lib
	make prefix=${D}/usr install || die
}
