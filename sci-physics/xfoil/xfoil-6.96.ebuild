# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/xfoil/xfoil-6.96.ebuild,v 1.3 2007/09/27 08:12:16 bicatali Exp $

inherit toolchain-funcs fortran

DESCRIPTION="Design and analysis of subsonic isolated airfoils"
HOMEPAGE="http://raphael.mit.edu/xfoil/"
SRC_URI="http://web.mit.edu/drela/Public/web/${PN}/${PN}${PV}.tar.gz
doc? ( http://web.mit.edu/drela/Public/web/${PN}/dataflow.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc examples"

DEPEND="x11-libs/libX11"

RESTRICT="test"

S="${WORKDIR}/Xfoil"

FORTRAN="gfortran ifc g77"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -e 's/-O3//g' -i plotlib/config.make || die "sed plotlib/config.make failed"
	echo "CC = $(tc-getCC)" >> plotlib/config.make
	echo "FC = ${FORTRANC}" >> plotlib/config.make
	echo "CFLAGS += ${CFLAGS}" >> plotlib/config.make
	echo "FFLAGS += ${FFLAGS:--O2}" >> plotlib/config.make

	sed -i \
		-e "s/^\(FC.*\)/FC = ${FORTRANC}/g" \
		-e "s/^\(CC.*\)/CC = $(tc-getCC)/g" \
		-e "s/^\(FFLAGS .*\)/FFLAGS = ${FFLAGS}/g" \
		-e "s/^\(FFLOPT .*\)/FFLOPT = \$(FFLAGS)/g" \
		-e "s/^\(FFLAGS2 .*\)/FFLAGS2 = \$(FFLAGS)/g" \
		bin/Makefile orrs/bin/Makefile \
		|| die "sed for flags and compilers failed"

	# fix bug #147033
	[[ ${FORTRANC} == gfortran ]] && epatch "${FILESDIR}"/${P}-gfortran.patch

	# make everything double precision
	sed -i \
		-e 's:/var/local/codes/orrs/osmap.dat:/usr/share/xfoil/orrs/osmap.dat:' \
		-e 's:REAL*4:REAL:g' \
		orrs/src/osmap.f || die "sed osmap.f failed"
}

src_compile() {
	cd "${S}"/orrs/bin
	emake FLG="${FFLAGS}" FTNLIB="" OS || die "failed to build orrs"
	cd "${S}"/orrs
	bin/osgen osmaps_ns.lst
	cd "${S}"/plotlib
	emake DP="" || die "failed to build plotlib"
	cd "${S}"/bin
	for i in xfoil pplot pxplot; do
		emake CFLAGS="${CFLAGS} -DUNDERSCORE" ${i} || die "failed to build ${i}"
	done
}

src_install() {
	dobin bin/pplot bin/pxplot bin/xfoil || die "dobin failed"
	insinto /usr/share/xfoil/orrs
	doins orrs/osm*.dat || die "orrs data install failed"
	dodoc *.txt README || die "dodoc failed"
	insinto /usr/share/doc/${PF}/
	use examples && { doins -r runs || die "examples install failed"; }
	use doc && { doins "${DISTDIR}"/dataflow.pdf || die "doc install failed"; }
}
