# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.4.ebuild,v 1.4 2006/03/17 14:11:22 corsair Exp $

inherit eutils

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="static zlib ssl mpi hlapi szip"

DEPEND="zlib? ( sys-libs/zlib )
		szip? ( sci-libs/szip )
		mpi? ( virtual/mpi )"

src_compile() {
	local myconf

	#--disable-static conflicts with --enable-cxx, so we have to do either or
	use static && myconf="--enable-cxx" || myconf="--disable-static"
	use zlib || myconf="${myconf} --disable-zlib"
	use ssl && myconf="${myconf} --with-ssl"
	use mpi && myconf="${myconf} --enable-parallel"
	use hlapi || myconf="${myconf} --disable-hl"

	# NOTE: the hdf5 configure script has its own interpretation of
	# the ARCH environment variable which conflicts with that of
	# ebuild/emerge. As a work around, we save the ARCH variable as
	# EBUILD_ARCH and restore it when we are done.
	EBUILD_ARCH=${ARCH}
	unset ARCH

	use mpi && \
	export CC="/usr/bin/mpicc"
	./configure ${myconf} --enable-linux-lfs \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "configure failed"

	# restore the ARCH environment variable
	ARCH=${EBUILD_ARCH}

	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		libdir=${D}/usr/$(get_libdir)/ \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	dodoc README.txt COPYING MANIFEST
	dohtml doc/html/*
}
