# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/abinit/abinit-6.0.4.ebuild,v 1.3 2011/06/21 09:54:58 jlec Exp $

EAPI="3"

inherit eutils fortran-2 toolchain-funcs autotools

DESCRIPTION="Find total energy, charge density and electronic structure using density functional theory"
HOMEPAGE="http://www.abinit.org/"
SRC_URI="http://ftp.abinit.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug mpi netcdf plugins test"

RDEPEND="virtual/blas
	virtual/lapack"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	fortran-2_pkg_setup
	# Doesn't compile with gcc-4.0, only >=4.1
	if [[ $(tc-getFC) == *gfortran ]]; then
		if [[ $(gcc-major-version) -eq 4 ]] \
			&& [[ $(gcc-minor-version) -lt 1  ]]; then
				die "Requires gcc-4.1 or newer"
		fi
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-change-default-directories.patch
	epatch "${FILESDIR}"/${PV}-test.patch

	# bug #223111: Our eautoreconf directory detection breaks
	sed -i -e "s:@abinit_srcdir@/::" Makefile.am

	# bug #223111: libtool 2.2 fix (taken from bug #230271)
	if [ -f "${EPREFIX}/usr/share/aclocal/ltsugar.m4" ]; then
		cat "${EPREFIX}/usr/share/aclocal/ltsugar.m4" >> config/m4/libtool.m4
		cat "${EPREFIX}/usr/share/aclocal/ltversion.m4" >> config/m4/libtool.m4
		cat "${EPREFIX}/usr/share/aclocal/lt~obsolete.m4" >> config/m4/libtool.m4
		cat "${EPREFIX}/usr/share/aclocal/ltoptions.m4" >> config/m4/libtool.m4
	fi

	# Yea for breaking compatibility with no ChangeLog entry in 2.60
	if has_version '>=sys-devel/autoconf-2.60'; then
		sed -i -e "s:_AC_SRCPATHS:_AC_SRCDIRS:g" config/scripts/make-macros-autotools
	fi
	eautoreconf
	use mpi && export CC=mpicc FC=mpif90
}

src_configure() {
	econf \
		--disable-config-file \
		--with-linalg-includes="$(pkg-config --cflags blas lapack)" \
		--with-linalg-libs="$(pkg-config --libs blas lapack)" \
		--with-cc-optflags="${CFLAGS}" \
		--with-fc-optflags="${FFLAGS}" \
		$(use_enable mpi) \
		$(use_enable plugins all-plugins) \
		$(use_enable netcdf) \
		$(use_enable debug) \
		FC="$(tc-getFC)" \
		CC="$(tc-getCC)" \
		LD="$(tc-getLD)"
}

src_test() {
	einfo "The tests take quite a while, on the order of 2-3 hours"
	einfo "on a dual Athlon 2000+."
	cd "${S}"/tests
	emake tests_min || die

	local REPORT
	for REPORT in $(find . -name *fl*); do
		elog "Results for ${REPORT%%/*} tests"
		while read line; do
			elog "${line}"
		done \
			< <(cat ${REPORT} )
	done
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc KNOWN_PROBLEMS README || die

	mv "${ED}"usr/share/doc/abinit/manpages/abinit.1 "${ED}"/usr/share/man/man1/
	mv "${ED}"usr/share/doc/abinit{,-${PVR}}
}

pkg_postinst() {
	if use test; then
		elog "The test results will be installed as summary_tests.tar.gz."
	fi
}
