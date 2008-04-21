# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmpi/openmpi-1.2.6.ebuild,v 1.1 2008/04/21 14:18:35 jsbronder Exp $

inherit eutils multilib flag-o-matic toolchain-funcs fortran

MY_P=${P/-mpi}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high-performance message passing library (MPI)"
HOMEPAGE="http://www.open-mpi.org"
SRC_URI="http://www.open-mpi.org/software/ompi/v1.2/downloads/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86 ~ppc"
IUSE="pbs fortran nocxx threads romio heterogeneous smp ipv6"
RDEPEND="pbs? ( sys-cluster/torque )
	!sys-cluster/mpich
	!sys-cluster/lam-mpi
	!sys-cluster/mpich2"
DEPEND="${RDEPEND}"

pkg_setup() {
	if use threads; then
		ewarn
		ewarn "WARNING: use of threads is still disabled by default in"
		ewarn "upstream builds."
		ewarn "You may stop now and set USE=-threads"
		ewarn
		epause 5
	fi

	elog
	elog "OpenMPI has an overwhelming count of configuration options."
	elog "Don't forget the EXTRA_ECONF environment variable can let you"
	elog "specify configure options if you find them necessary."
	elog

	if use fortran; then
		FORTRAN="g77 gfortran ifc"
		fortran_pkg_setup
	fi
}

src_compile() {
	local myconf="
		--sysconfdir=/etc/${PN}
		--without-xgrid
		--enable-pretty-print-stacktrace
		--enable-orterun-prefix-by-default
		--without-slurm"

	if use threads; then
		myconf="${myconf}
			--enable-mpi-threads
			--with-progress-threads
			--with-threads=posix"
	fi

	if use fortran; then
		if [[ "${FORTRANC}" = "g77" ]]; then
			myconf="${myconf} --disable-mpi-f90"
		elif [[ "${FORTRANC}" = "gfortran" ]]; then
			# Because that's just a pain in the butt.
			myconf="${myconf} --with-wrapper-fflags=-I/usr/include"
		elif [[ "${FORTRANC}" = if* ]]; then
			# Enabled here as gfortran compile times are huge with this enabled.
			myconf="${myconf} --with-mpi-f90-size=medium"
		fi
	else
		myconf="${myconf}
			--disable-mpi-f90
			--disable-mpi-f77"
	fi

	econf ${myconf} \
		$(use_enable !nocxx mpi-cxx) \
		$(use_enable romio romio-io) \
		$(use_enable smp smp-locks) \
		$(use_enable heterogeneous) \
		$(use_with pbs tm) \
		$(use_enable ipv6) \
	|| die "econf failed"

	emake  || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS NEWS VERSION
}

src_test() {
	# Doesn't work with the default src_test as the dry run (-n) fails.
	cd "${S}"
	emake -j1 check || die "emake check failed"
}
