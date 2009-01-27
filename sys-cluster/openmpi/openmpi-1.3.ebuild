# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmpi/openmpi-1.3.ebuild,v 1.1 2009/01/27 03:44:04 jsbronder Exp $

EAPI=1
inherit eutils multilib flag-o-matic toolchain-funcs fortran

MY_P=${P/-mpi}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high-performance message passing library (MPI)"
HOMEPAGE="http://www.open-mpi.org"
SRC_URI="http://www.open-mpi.org/software/ompi/v1.3/downloads/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
RESTRICT="mpi-threads? ( test )"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+cxx fortran heterogeneous ipv6 mpi-threads pbs romio threads"
RDEPEND="pbs? ( sys-cluster/torque )
	!sys-cluster/mpich
	!sys-cluster/lam-mpi
	!sys-cluster/mpich2
	!sys-cluster/mpiexec"
DEPEND="${RDEPEND}"

pkg_setup() {
	if use mpi-threads; then
		ewarn
		ewarn "WARNING: use of MPI_THREAD_MULTIPLE is still disabled by"
		ewarn "default and officially unsupported by upstream."
		ewarn "You may stop now and set USE=-mpi-threads"
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

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Necessary for scalibility, see
	# http://www.open-mpi.org/community/lists/users/2008/09/6514.php
	if use threads; then
		echo 'oob_tcp_listen_mode = listen_thread' \
			>> opal/etc/openmpi-mca-params.conf
	fi
}

src_compile() {
	local myconf="
		--sysconfdir=/etc/${PN}
		--without-xgrid
		--enable-pretty-print-stacktrace
		--enable-orterun-prefix-by-default
		--without-slurm"

	if use mpi-threads; then
		myconf="${myconf}
			--enable-mpi-threads
			--with-progress-threads"
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
		$(use_enable cxx mpi-cxx) \
		$(use_enable romio io-romio) \
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
