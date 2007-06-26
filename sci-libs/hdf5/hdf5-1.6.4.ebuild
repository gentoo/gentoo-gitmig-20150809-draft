# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.4.ebuild,v 1.8 2007/06/26 02:43:01 mr_bones_ Exp $

inherit eutils

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
# need to update szip to get sparc, alpha, and ia64 back in here,
# as well as work out the mpi issues
IUSE="static zlib ssl mpi hlapi szip threads debug"

DEPEND="zlib? ( sys-libs/zlib )
		szip? ( sci-libs/szip )
		mpi? ( sys-cluster/mpich2 )"

src_compile() {
	local myconf="--with-pic"

	#--disable-static conflicts with --enable-cxx, so we have to do either or
	use static && myconf="${myconf} --enable-cxx" || \
	    myconf="${myconf} --disable-static"
	# fortran needs f90 support
	#myconf="${myconf} $(use_enable fortran)"
	use threads && myconf="${myconf} --with-pthread"
	use debug && myconf="${myconf} --enable-debug=all"
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
	./configure --prefix=/usr ${myconf} \
		$(use_enable zlib) \
		$(use_with ssl) \
		--enable-linux-lfs  \
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
