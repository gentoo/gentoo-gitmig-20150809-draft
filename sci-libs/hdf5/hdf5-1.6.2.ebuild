# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.2.ebuild,v 1.6 2007/12/03 07:21:53 nerdboy Exp $

inherit eutils

DESCRIPTION="general purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="static zlib ssl threads debug"

DEPEND="zlib? ( sys-libs/zlib )"

src_compile() {
	local myconf="--with-pic"

	#--disable-static conflicts with --enable-cxx, so we have to do either or
	use static && myconf="${myconf} --enable-cxx" || \
	    myconf="${myconf} --disable-static"
	# fortran needs f90 support
	#use fortran && myconf="${myconf} --enable-fortran"
	use threads && myconf="${myconf} --with-pthread"
	use debug && myconf="${myconf} --enable-debug=all"

	# NOTE: the hdf5 configure script has its own interpretation of
	# the ARCH environment variable which conflicts with that of
	# ebuild/emerge. As a work around, we save the ARCH variable as
	# EBUILD_ARCH and restore it when we are done.
	EBUILD_ARCH=${ARCH}
	unset ARCH

	./configure --prefix=/usr ${myconf} \
		$(use_enable zlib) \
		$(use_with ssl) \
		--enable-linux-lfs  \
		--libdir=/usr/$(get_libdir) \
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
		libdir=${D}/usr/$(get_libdir) \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	dodoc README.txt MANIFEST
	dohtml doc/html/*
}
