# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hdf5/hdf5-1.4.5.ebuild,v 1.1 2003/06/19 07:51:43 george Exp $

DESCRIPTION="HDF5 is a general purpose library and file format for storing scientific data."
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/HDF5/current/src/${P}-post2.tar.gz"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"

LICENSE="NCSA-HDF"
KEYWORDS="~x86"
SLOT="0"
IUSE="static zlib"

DEPEND="zlib? ( sys-libs/zlib )"
PROVIDE="dev-libs/hdf5"

# set the source directory
S=${WORKDIR}/${P}-post2

src_compile() {
	local myconf

	use static || myconf="--disable-static"
	use zlib || myconf="${myconf} --disable-zlib"

	# NOTE: the hdf5 configure script has its own interpretation of
	# the ARCH environment variable which conflicts with that of
	# ebuild/emerge. As a work around, we save the ARCH variable as
	# EBUILD_ARCH and restore it when we are done.
	EBUILD_ARCH=${ARCH}
	unset ARCH

	./configure ${myconf} --enable-linux-lfs \
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
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	dodoc README.txt COPYING MANIFEST
	dohtml doc/html/*
}
