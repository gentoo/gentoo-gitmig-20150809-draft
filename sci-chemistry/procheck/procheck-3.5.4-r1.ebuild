# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/procheck/procheck-3.5.4-r1.ebuild,v 1.1 2010/07/19 17:16:04 jlec Exp $

EAPI="3"

inherit eutils fortran toolchain-funcs versionator

DESCRIPTION="Checks the stereochemical quality of a protein structure"
HOMEPAGE="http://www.biochem.ucl.ac.uk/~roman/procheck/procheck.html"
SRC_URI="
	${P}.tar.gz ${P}-README
	doc? ( ${P}-manual.tar.gz )"

LICENSE="procheck"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND="app-shells/tcsh"
DEPEND="${RDEPEND}"

RESTRICT="fetch"

S="${WORKDIR}/${PN}"

FORTRAN="gfortran g77"

pkg_nofetch() {
	elog "Please visit http://www.ebi.ac.uk/thornton-srv/software/PROCHECK/download.html"
	elog "And follow the instruction for downloading."
	elog "Files should be stored in following way"
	elog "${PN}.tar.gz  ->  ${DISTDIR}/${P}.tar.gz"
	elog "README  ->  ${DISTDIR}/${P}-README"
	if use doc; then
		elog "manual.tar.gz  ->  ${DISTDIR}/${P}-manual.tar.gz"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch
}

src_compile() {
	emake \
		F77=${FORTRANC} \
		CC=$(tc-getCC) \
		COPTS="${CFLAGS}" \
		FOPTS="${FFLAGS}" \
		|| die "emake failed"
}

src_install() {
	for i in *.scr; do
		newbin ${i} ${i%.scr} || die
	done

	exeinto /usr/$(get_libdir)/${PN}/
	doexe \
		anglen \
		clean \
		rmsdev \
		secstr \
		gfac2pdb \
		pplot \
		bplot \
		tplot \
		mplot \
		vplot \
		viol2pdb \
		wirplot \
		nb || die
	dodoc "${DISTDIR}"/${P}-README || die

	insinto /usr/$(get_libdir)/${PN}/
	doins *.dat *.prm || die
	newins resdefs.dat resdefs.data || die

	cat >> "${T}"/30${PN} <<- EOF
	prodir="${EPREFIX}/usr/$(get_libdir)/${PN}/"
	EOF

	doenvd "${T}"/30${PN} || die

	if use doc; then
		pushd "${WORKDIR}"
			dohtml -r manual || die
		popd
	fi
}
