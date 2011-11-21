# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.8.8.ebuild,v 1.2 2011/11/21 17:33:09 xarthisius Exp $

EAPI=4

inherit autotools eutils fortran-2

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://www.hdfgroup.org/HDF5/"
SRC_URI="http://www.hdfgroup.org/ftp/HDF5/releases/${P}/src/${P}.tar.bz2"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="cxx debug examples fortran fortran2003 mpi static-libs szip threads zlib"
REQUIRED_USE="fortran2003? ( fortran )"

RDEPEND="
	fortran? ( virtual/fortran )
	mpi? ( virtual/mpi[romio] )
	szip? ( >=sci-libs/szip-2.1 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	sys-devel/libtool:2"

pkg_setup() {
	if use fortran; then
		use fortran2003 && FORTRAN_STANDARD=2003
		fortran-2_pkg_setup
	fi
	if use mpi; then
		if has_version 'sci-libs/hdf5[-mpi]'; then
			ewarn "Installing hdf5 with mpi enabled with a previous hdf5 with mpi disabled may fail."
			ewarn "Try to uninstall the current hdf5 prior to enabling mpi support."
		fi
		if use cxx; then
			ewarn "Simultaneous mpi and cxx is not supported by ${PN}"
			ewarn "Will disable cxx interface"
		fi
		export CC=mpicc
		use fortran && export FC=mpif90
	elif has_version 'sci-libs/hdf5[mpi]'; then
		ewarn "Installing hdf5 with mpi disabled while having hdf5 installed with mpi enabled may fail."
		ewarn "Try to uninstall the current hdf5 prior to disabling mpi support."
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-buildsystem.patch \
		"${FILESDIR}"/${P}-array_bounds.patch \
		"${FILESDIR}"/${P}-implicits.patch
	# respect gentoo examples directory
	sed \
		-e "s:hdf5_examples:doc/${PF}/examples:g" \
		-i $(find . -name Makefile.am) $(find . -name "run*.sh.in") || die
	sed \
		-e '/docdir/d' \
		-i config/commence.am || die
	eautoreconf
	# enable shared libs by default for h5cc config utility
	sed -i -e "s/SHLIB:-no/SHLIB:-yes/g" tools/misc/h5cc.in	|| die
}

src_configure() {
	# threadsafe incompatible with many options
	local myconf="--disable-threadsafe"
	use debug && myconf="${myconf} --enable-codestack"
	use threads && ! use fortran && ! use cxx && ! use mpi \
		&& myconf="--enable-threadsafe"

	if use mpi; then
		myconf="${myconf} --disable-cxx"
	else
	# workaround for bug 285148
		if use cxx; then
			myconf="${myconf} $(use_enable cxx) CXX=$(tc-getCXX)"
		fi
		if use fortran; then
			myconf="${myconf} FC=$(tc-getFC)"
		fi
	fi

	econf \
		--disable-sharedlib-rpath \
		--enable-production \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--enable-deprecated-symbols \
		--enable-shared \
		--disable-silent-rules \
		$(use_enable static-libs static) \
		$(use_enable debug debug all) \
		$(use_enable fortran) \
		$(use_enable fortran2003) \
		$(use_enable mpi parallel) \
		$(use_with szip szlib) \
		$(use_with threads pthread) \
		$(use_with zlib) \
		${myconf}
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -exec rm -f {} +

	if use examples; then
		emake DESTDIR="${D}" install-examples
	fi
}
