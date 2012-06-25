# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmpi/openmpi-1.5.4-r3.ebuild,v 1.3 2012/06/25 18:28:11 jsbronder Exp $

EAPI=4
inherit eutils fortran-2 multilib flag-o-matic toolchain-funcs

MY_P=${P/-mpi}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high-performance message passing library (MPI)"
HOMEPAGE="http://www.open-mpi.org"
SRC_URI="http://www.open-mpi.org/software/ompi/v${P%.*}/downloads/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux"
IUSE="+cxx elibc_FreeBSD fortran heterogeneous infiniband ipv6 knem mpi-threads
	+numa open-mx pbs psm romio sctp slurm threads vt"

REQUIRED_USE="slurm? ( !pbs )
	pbs? ( !slurm )
	psm? ( infiniband )"

RDEPEND="
	elibc_FreeBSD? ( dev-libs/libexecinfo )
	fortran? ( virtual/fortran )
	infiniband? ( sys-infiniband/ofed )
	knem? ( sys-cluster/knem )
	numa? ( sys-process/numactl )
	open-mx? ( sys-cluster/open-mx )
	pbs? ( sys-cluster/torque )
	psm? ( sys-infiniband/infinipath-psm )
	sctp? ( net-misc/lksctp-tools )
	vt? (
		!dev-libs/libotf
		!app-text/lcdf-typetools
	)
	>=sys-apps/hwloc-1.3
	!sys-cluster/mpich2
	!sys-cluster/mpiexec"
DEPEND="${RDEPEND}"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
	if use mpi-threads; then
		echo
		ewarn "WARNING: use of MPI_THREAD_MULTIPLE is still disabled by"
		ewarn "default and officially unsupported by upstream."
		ewarn "You may stop now and set USE=-mpi-threads"
		echo
	fi

	echo
	elog "OpenMPI has an overwhelming count of configuration options."
	elog "Don't forget the EXTRA_ECONF environment variable can let you"
	elog "specify configure options if you find them necessary."
	echo
}

src_prepare() {
	# Necessary for scalibility, see
	# http://www.open-mpi.org/community/lists/users/2008/09/6514.php
	if use threads; then
		echo 'oob_tcp_listen_mode = listen_thread' \
			>> opal/etc/openmpi-mca-params.conf
	fi

	epatch "${FILESDIR}"/openmpi-r24328.patch
}

src_configure() {
	local myconf=(
		--sysconfdir="${EPREFIX}/etc/${PN}"
		--enable-pretty-print-stacktrace
		--enable-orterun-prefix-by-default
		--with-hwloc="${EPREFIX}/usr"
		)

	if use mpi-threads; then
		myconf+=(--enable-mpi-thread-multiple
			--enable-opal-multi-threads
			)
	fi

	if use fortran; then
		if [[ $(tc-getFC) =~ g77 ]]; then
			myconf+=(--disable-mpi-f90)
		elif [[ $(tc-getFC) =~ if ]]; then
			# Enabled here as gfortran compile times are huge with this enabled.
			myconf+=(--with-mpi-f90-size=medium)
		fi
	else
		myconf+=(--disable-mpi-f90 --disable-mpi-f77)
	fi

	! use vt && myconf+=(--enable-contrib-no-build=vt)

	use numa && myconf+=( --with-libnuma="${EPREFIX}/usr" )
	use infiniband && myconf+=( --with-openib="${EPREFIX}/usr" )
	use open-mx && myconf+=( --with-mx="${EPREFIX}/usr" )
	use psm && myconf+=( --with-psm="${EPREFIX}/usr" )
	use knem && myconf+=( --with-knem="${EPREFIX}/usr" )

	econf "${myconf[@]}" \
		$(use_enable cxx mpi-cxx) \
		$(use_enable romio io-romio) \
		$(use_enable heterogeneous) \
		$(use_enable ipv6) \
		$(use_with infiniband openib "${EPREFIX}"/usr) \
		$(use_with knem knem "${EPREFIX}"/usr) \
		$(use_with numa libnuma "${EPREFIX}"/usr) \
		$(use_with open-mx mx "${EPREFIX}"/usr) \
		$(use_with pbs tm) \
		$(use_with psm psm "${EPREFIX}"/usr) \
		$(use_with sctp sctp) \
		$(use_with slurm)
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	# From USE=vt see #359917
	rm "${ED}"/usr/share/libtool &> /dev/null
	dodoc README AUTHORS NEWS VERSION || die
}

src_test() {
	# Doesn't work with the default src_test as the dry run (-n) fails.
	emake -j1 check || die "emake check failed"
}
