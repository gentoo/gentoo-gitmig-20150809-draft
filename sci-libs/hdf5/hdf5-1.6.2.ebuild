# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.2.ebuild,v 1.2 2005/04/01 17:12:38 agriffis Exp $

DESCRIPTION="general purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~sparc x86"
IUSE="static zlib ssl"

DEPEND="zlib? ( sys-libs/zlib )"

src_compile() {
	local myconf

	#--disable-static conflicts with --enable-cxx, so we have to do either or
	use static && myconf="--enable-cxx" || myconf="--disable-static"
	use zlib || myconf="${myconf} --disable-zlib"
	use ssl && myconf="${myconf} --with-ssl"

	# NOTE: the hdf5 configure script has its own interpretation of
	# the ARCH environment variable which conflicts with that of
	# ebuild/emerge. As a work around, we save the ARCH variable as
	# EBUILD_ARCH and restore it when we are done.
	EBUILD_ARCH=${ARCH}
	unset ARCH

	./configure ${myconf} --enable-linux-lfs --with-gnu-ld \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "configure failed"

	# restore the ARCH environment variable
	ARCH=${EBUILD_ARCH}

	make || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	dodoc README.txt COPYING MANIFEST
	dohtml doc/html/*
}
