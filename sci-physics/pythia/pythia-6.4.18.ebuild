# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/pythia/pythia-6.4.18.ebuild,v 1.3 2008/09/16 21:43:43 jer Exp $

inherit fortran versionator autotools

MV=$(get_major_version)
MY_PN=${PN}${MV}
DOC_PV=0613

DESCRIPTION="Lund Monte Carlo high-energy physics event generator"
HOMEPAGE="http://projects.hepforge.org/pythia6/"

# pythia6 from root is needed for some files to interface pythia6 with root
SRC_URI="http://www.hepforge.org/archive/${MY_PN}/${P}.f.gz
	http://www.hepforge.org/archive/${MY_PN}/update_notes-${PV}.txt
	ftp://root.cern.ch/root/pythia6.tar.gz
	doc? ( http://home.thep.lu.se/~torbjorn/pythia/lutp${DOC_PV}man2.pdf )
	examples? ( mirror://gentoo/${P}-examples.tar.bz2 )"

LICENSE="public-domain"
SLOT="6"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE="doc examples"
DEPEND=""

S="${WORKDIR}"

FORTRAN="gfortran ifc g77"

S="${WORKDIR}"
src_unpack() {
	unpack ${A}
	cat > configure.ac <<-EOF
		AC_INIT(${PN},${PV})
		AM_INIT_AUTOMAKE
		AC_PROG_F77
		AC_PROG_LIBTOOL
		AC_CONFIG_FILES(Makefile)
		AC_OUTPUT
	EOF
	cat > Makefile.am <<-EOF
		lib_LTLIBRARIES = lib${MY_PN}.la
		lib${MY_PN}_la_SOURCES = ${P}.f \
		   pythia6/tpythia6_called_from_cc.F \
		   pythia6/pythia6_common_address.c
	EOF
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc "${DISTDIR}"/update_notes-${PV}.txt
	insinto /usr/share/doc/${PF}/
	if use doc; then
		doins "${DISTDIR}"/lutp${DOC_PV}man2.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
