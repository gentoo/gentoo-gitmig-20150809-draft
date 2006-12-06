# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmpi/openmpi-1.1.2.ebuild,v 1.2 2006/12/06 23:33:02 dberkholz Exp $

inherit eutils multilib flag-o-matic toolchain-funcs fortran


MY_P=${P/-mpi}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high-performance message passing library (MPI)"
HOMEPAGE="http://www.open-mpi.org"
SRC_URI="http://www.open-mpi.org/software/ompi/v1.1/downloads/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pbs fortran threads"
PROVIDE="virtual/mpi"
RDEPEND="virtual/libc
		pbs? ( virtual/pbs )"
DEPEND="${RDEPEND}"

FORTRAN="ifc gfortran g77"

pkg_setup() {
	if use threads; then
		ewarn
		ewarn "WARNING: use of threads is highly experimental."
		ewarn "You may stop now and set USE=-threads"
		ewarn
		epause 5
	fi
	use fortran && fortran_pkg_setup
}

src_compile() {

	einfo
	einfo "OpenMPI has an overwhelming count of configuration options."
	einfo "Don't forget the EXTRA_ECONF environment variable can let you"
	einfo "specify configure options."
	einfo

	local myconf="--sysconfdir=/etc/${PN}"
	myconf="${myconf} --enable-pretty-print-stacktrace"

	if use threads; then
		myconf="${myconf} --enable-mpi-threads"
		myconf="${myconf} --with-progress-threads"
		myconf="${myconf} --with-threads=posix"
	fi

	if use fortran; then
		myconf="${myconf} $(use enable fortran mpi-f77)"
		[ "${FORTRANC}" = "g77" ] && \
			myconf="${myconf} --disable-mpi-f90" || \
			myconf="${myconf} --enable-mpi-f90"
	fi

	use pbs && myconf="${myconf} $(use_with pbs tm /usr/$(get_libdir)/pbs)"
	append-ldflags -Wl,-z,-noexecstack

	econf ${myconf} || die "econf failed"
	emake  || die "emake failed"
}

src_install () {

	make DESTDIR="${D}" install || die "make install failed"

	dodoc README AUTHORS NEWS VERSION
}
