# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-3.6.2.ebuild,v 1.7 2007/12/06 18:39:00 drac Exp $

inherit fortran eutils toolchain-funcs flag-o-matic autotools

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.gz"
HOMEPAGE="http://my.unidata.ucar.edu/content/software/netcdf/index.html"

LICENSE="UCAR-Unidata"
SLOT="0"
IUSE="fortran debug doc"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

pkg_setup() {
	if use fortran ; then
		FORTRAN="gfortran ifc g77 pgf77 pgf90"
		fortran_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-parallel-make.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	eautoreconf
}

src_compile() {
	use debug || append-cppflags -DNDEBUG
	local myconf
	if use fortran; then
		case "${FORTRANC}" in
			g77)
				myconf="${myconf} --enable-f77 --disable-f90"
				myconf="${myconf} F77=g77"
				;;
			pgf77)
				myconf="${myconf} --enable-f77 --disable-f90"
				myconf="${myconf} F77=pgf77"
				;;
			pgf90)
				myconf="${myconf} --enable-f77 --enable-f90"
				myconf="${myconf} FC=pgf90 F90=pgf90 F77=pgf90"
				;;
			ifc|ifort)
				myconf="${myconf} --enable-f77 --enable-f90"
				myconf="${myconf} FC=ifort F90=ifort F77=ifort"
				;;
			*)
				myconf="${myconf} --enable-f77 --enable-f90"
				myconf="${myconf} FC=gfortran F90=gfortran F77=gfortran"
				export F90FLAGS="-i4  ${F90FLAGS}"
				;;
		esac
		# fortran 90 uses FCFLAGS
		export FCFLAGS="${FFLAGS:--O2}"
	else
		myconf="${myconf} --disable-f77 --disable-f90"
	fi
	econf \
		--enable-shared \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable debug flag-setting ) \
		$(use_enable doc docs-install) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README RELEASE_NOTES VERSION || die "dodoc failed"
	# keep only pdf,txt and html docs, info were already installed
	if use doc; then
		find "${D}usr/share/doc/${PF}" -name \*.ps -exec rm -f {} \;
		find "${D}usr/share/doc/${PF}" -name \*.info -exec rm -f {} \;
		find "${D}usr/share/doc/${PF}" -name \*.txt -exec ecompress {} \;
	fi
}
