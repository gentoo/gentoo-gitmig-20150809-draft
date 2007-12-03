# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.5.ebuild,v 1.4 2007/12/03 07:21:53 nerdboy Exp $

inherit eutils

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
# need to update szip to get sparc, alpha, and ia64 back in here,
# as well as work out the mpi issues
IUSE="static zlib ssl mpi hlapi szip threads debug"

DEPEND="zlib? ( sys-libs/zlib )
		szip? ( sci-libs/szip )
		mpi? ( virtual/mpi )"

src_compile() {
	local myconf="--with-pic"

	#--disable-static conflicts with --enable-cxx, so we have to do either or
	use static && myconf="${myconf} --enable-cxx" || \
	    myconf="${myconf} --disable-static"
	# fortran needs f90 support
	#myconf="${myconf} $(use_enable fortran)"
	use threads && myconf="${myconf} --with-pthread"
	use debug && myconf="${myconf} --enable-debug=all"
	use mpi && myconf="${myconf} --enable-parallel --disable-cxx"
	use hlapi || myconf="${myconf} --disable-hl"

	# NOTE: the hdf5 configure script has its own interpretation of
	# the ARCH environment variable which conflicts with that of
	# ebuild/emerge. As a work around, we save the ARCH variable as
	# EBUILD_ARCH and restore it when we are done.
	EBUILD_ARCH=${ARCH}
	unset ARCH

	if use mpi ; then
	    export CC="/usr/bin/mpicc"
	fi
	./configure --prefix=/usr ${myconf} \
		$(use_enable zlib) \
		$(use_with ssl) \
		--enable-linux-lfs  \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "configure failed"

	# restore the ARCH environment variable
	ARCH=${EBUILD_ARCH}

	make || die "make failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		libdir=${D}/usr/$(get_libdir)/ \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	dolib.so ${S}/test/.libs/lib*so* || die "dolib.so failed"

	if use static ; then
	    dolib.a ${S}/tools/lib/.libs/libh5tools.a \
		${S}/test/.libs/libh5test.a || die "dolib.a failed"
	    insinto /usr/$(get_libdir)
	    doins ${S}/tools/lib/libh5tools.la \
		${S}/test/libh5test.la || die "doins failed"
	fi

	dobin ${S}/bin/iostats || die "dobin failed"

	dodoc README.txt MANIFEST
	dohtml doc/html/*

	if use mpi ; then
	    mv ${D}usr/bin/h5pcc ${D}usr/bin/h5cc
	fi
	# change the SHLIB default for C
	if ! use static ; then
	    dosed "s/SHLIB:-no/SHLIB:-yes/g" ${D}usr/bin/h5cc || die "dosed failed"
	fi
}
