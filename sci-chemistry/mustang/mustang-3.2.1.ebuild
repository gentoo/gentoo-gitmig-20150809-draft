# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mustang/mustang-3.2.1.ebuild,v 1.3 2010/07/06 13:31:28 jlec Exp $

EAPI="3"

inherit base toolchain-funcs

MY_PN="MUSTANG"
SRC_P="${PN}_v${PV}"
MY_P="${MY_PN}_v${PV}"

DESCRIPTION="MUltiple STructural AligNment AlGorithm."
HOMEPAGE="http://www.cs.mu.oz.au/~arun/mustang/"
SRC_URI="http://www.csse.unimelb.edu.au/~arun/${PN}/${SRC_P}.tgz -> ${P}.tar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake \
		CPP=$(tc-getCXX) \
		CPPFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_test() {
	./bin/${P} -f ./data/test/test_zf-CCHH || die
}

src_install() {
	newbin bin/${P} mustang || die
	doman man/${PN}.1 || die
	dodoc README || die
}

pkg_postinst() {
	elog "If you use this program for an academic paper, please cite:"
	elog "Arun S. Konagurthu, James C. Whisstock, Peter J. Stuckey, and Arthur M. Lesk"
	elog "Proteins: Structure, Function, and Bioinformatics. 64(3):559-574, Aug. 2006"
}
