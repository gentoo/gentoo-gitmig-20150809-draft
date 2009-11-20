# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.8.4.ebuild,v 1.1 2009/11/20 22:41:05 bicatali Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://www.hdfgroup.org/HDF5/"
SRC_URI="http://www.hdfgroup.org/ftp/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

IUSE="cxx examples fortran mpi szip threads zlib"

RDEPEND="mpi? ( || (
			sys-cluster/openmpi[romio]
			sys-cluster/mpich2[romio]
			>=sys-cluster/lam-mpi-7.1.4[romio] ) )
	szip? ( >=sci-libs/szip-2.1 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-2.2
	sys-process/time"

pkg_setup() {
	if use mpi; then
		if use cxx; then
			ewarn "Simultaneous mpi and cxx is not supported by ${PN}"
			ewarn "Will disable cxx interface"
		fi
		export CC=mpicc
		if use fortran; then
			# can't make mpi and fortran to work
			#export FC=mpif90
			ewarn "Simultaneous use of mpi and fortran for ${PN} will not compile"
			ewarn "Disabling fortran interface"
		fi
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.8.3-as-needed.patch
	epatch "${FILESDIR}"/${PN}-1.8.3-includes.patch
	epatch "${FILESDIR}"/${PN}-1.8.3-noreturn.patch
	epatch "${FILESDIR}"/${PN}-1.8.3-destdir.patch
	epatch "${FILESDIR}"/${PN}-1.8.3-signal.patch

	# gentoo examples directory
	sed -i \
		-e 's:$(docdir)/hdf5:$(docdir):' \
		$(find . -name Makefile.am) || die
	eautoreconf
	# enable shared libs by default for h5cc config utility
	sed -i -e "s/SHLIB:-no/SHLIB:-yes/g" tools/misc/h5cc.in \
		|| die "sed h5cc.in failed"
}

src_configure() {
	# threadsafe incompatible with many options
	local myconf="--disable-threadsafe"
	use threads && ! use fortran && ! use cxx && ! use mpi \
		&& myconf="--enable-threadsafe"

	if use mpi; then
		myconf="${myconf} --disable-cxx --disable-fortran"
	else
		myconf="${myconf} $(use_enable cxx) $(use_enable fortran)"
	fi

	econf \
		--disable-sharedlib-rpath \
		--enable-production \
		--enable-strict-format-checks \
		--docdir=/usr/share/doc/${PF} \
		--enable-deprecated-symbols \
		--enable-shared \
		$(use_enable mpi parallel) \
		$(use_with szip szlib) \
		$(use_with threads pthread) \
		$(use_with zlib) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt
	if use examples; then
		emake DESTDIR="${D}" install-examples \
			|| die "emake install examples failed"
	fi
}
