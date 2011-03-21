# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/aqua/aqua-3.2-r2.ebuild,v 1.2 2011/03/21 15:21:35 jlec Exp $

EAPI="3"

inherit eutils prefix toolchain-funcs

DESCRIPTION="Program suite in this distribution calculates restraint violations"
HOMEPAGE="http://www.biochem.ucl.ac.uk/~roman/procheck/procheck.html"
SRC_URI="
	${PN}${PV}.tar.gz
	doc? ( ${P}-nmr_manual.tar.gz )"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="procheck"
IUSE="doc examples"

RDEPEND="sci-chemistry/procheck"
DEPEND=""

RESTRICT="fetch"

S="${WORKDIR}"/${PN}${PV}

pkg_nofetch() {
	elog "Please visit http://www.ebi.ac.uk/thornton-srv/software/PROCHECK/download.html"
	elog "And follow the instruction for downloading ${PN}${PV}.tar.gz ->  ${DISTDIR}/${PN}${PV}.tar.gz."
	if use doc; then
		elog "nmr_manual.tar.gz  ->  ${DISTDIR}/${P}-nmr_manual.tar.gz"
	fi
}

src_prepare() {
	sed \
		-e 's:nawk:gawk:g' \
		-e "s:/bin/gawk:${EPREFIX}/usr/bin/gawk:g" \
		-e "s:/usr/local/bin/perl:${EPREFIX}/usr/bin/perl:g" \
		-i $(find . -type f) || die
	epatch "${FILESDIR}"/${PV}-flags.patch
}

src_compile() {
	pushd src > /dev/null
	emake \
		MYROOT="${WORKDIR}" \
		CC="$(tc-getCC)" \
		FC="$(tc-getFC)" \
		CFLAGS="${CFLAGS} -I../sub/lib" \
		FFLAGS="${FFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		exth || die
	emake \
		MYROOT="${WORKDIR}" \
		CC="$(tc-getCC)" \
		FC="$(tc-getFC)" \
		CFLAGS="${CFLAGS} -I../sub/lib" \
		FFLAGS="${FFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die
	popd
}

src_install() {
	rm -f scripts/conv* || die
	dobin bin/* scripts/* || die
	dosym AquaWhat /usr/bin/qwhat || die
	dosym AquaHow /usr/bin/qhow || die
	dosym AquaPseudo /usr/bin/qpseudo || die
	dosym AquaDist /usr/bin/qdist || die
	dosym AquaCalc /usr/bin/qcalc || die
	dosym AquaAssign /usr/bin/qassign || die
	dosym AquaRedun /usr/bin/qredun || die
	dosym AquaCompl /usr/bin/qcompl || die

	dodoc HISTORY HOW_TO_USE NEW README doc/* || die
	dohtml html/* || die

	insinto /usr/share/${PN}
	doins data/* || die
	if use examples; then
		doins -r exmpls || die
	fi

	if use doc; then
		dohtml -r manual || die
	fi

	cat >> "${T}"/34aqua <<- EOF
	AQUADATADIR="${EPREFIX}/usr/share/${PN}"
	EOF
	doenvd "${T}"/34aqua || die
}
