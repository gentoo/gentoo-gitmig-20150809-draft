# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/xfoil/xfoil-6.97.ebuild,v 1.5 2008/12/20 14:53:29 nixnut Exp $

inherit eutils fortran

DESCRIPTION="Design and analysis of subsonic isolated airfoils"
HOMEPAGE="http://raphael.mit.edu/xfoil/"
SRC_URI="http://web.mit.edu/drela/Public/web/${PN}/${PN}${PV}.tar.gz
	doc? ( http://web.mit.edu/drela/Public/web/${PN}/dataflow.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc examples"

DEPEND="x11-libs/libX11"

S="${WORKDIR}/Xfoil"
FORTRAN="gfortran ifc g77"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^FC/d' \
		-e '/^CC/d' \
		-e '/^FFLAGS/d' \
		-e '/^CFLAGS/d' \
		-e 's/^\(FFLOPT .*\)/FFLOPT = $(FFLAGS)/g' \
		{bin,plotlib,orrs/bin}/Makefile plotlib/config.make \
		|| die "sed for flags and compilers failed"

	# fix bug #147033
	[[ ${FORTRANC} == gfortran ]] && \
		epatch "${FILESDIR}"/${PN}-6.96-gfortran.patch
	epatch "${FILESDIR}"/${P}-overflow.patch
	sed -i \
		-e 's:/var/local/codes/orrs/osmap.dat:/usr/share/xfoil/orrs/osmap.dat:' \
		orrs/src/osmap.f || die "sed osmap.f failed"
}

src_compile() {
	export FC="${FORTRANC}" F77="${FORTRANC}"
	cd "${S}"/orrs/bin
	emake FLG="${FFLAGS}" FTNLIB="${LDFLAGS}" OS || die "failed to build orrs"
	cd "${S}"/orrs
	bin/osgen osmaps_ns.lst
	cd "${S}"/plotlib
	emake CFLAGS="${CFLAGS} -DUNDERSCORE" || die "failed to build plotlib"
	cd "${S}"/bin
	for i in xfoil pplot pxplot; do
		emake \
			PLTOBJ="../plotlib/libPlt.a" \
			CFLAGS="${CFLAGS} -DUNDERSCORE" \
			FTNLIB="${LDFLAGS}" \
			${i} || die "failed to build ${i}"
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
