# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/minisat/minisat-2.2.0-r2.ebuild,v 1.1 2011/04/10 08:40:48 xarthisius Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Small yet efficient SAT solver with reference paper."
HOMEPAGE="http://minisat.se/Main.html"
SRC_URI="http://minisat.se/downloads/${P}.tar.gz
	doc? ( http://minisat.se/downloads/MiniSat.pdf )"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="MIT"

IUSE="debug doc extended-solver"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	if use debug; then
		myconf="d"
		myext="debug"
	else
		myconf="r"
		myext="release"
	fi

	if use extended-solver; then
		mydir="simp"
	else
		mydir="core"
	fi
	tc-export CXX
}

src_prepare() {
	sed -e "s/\$(CXX) \$^/\$(CXX) \$(LDFLAGS) \$^/" \
		-i -e "s|-O3|${CFLAGS}|" mtl/template.mk || die
}

src_compile() {
	export MROOT="${S}"
	emake -C ${mydir} "$myconf" || die
	LIB="${PN}" emake -C ${mydir} lib"$myconf" || die
}

src_install() {
	# somewhat brute-force, but so is the build setup...
	insinto /usr/include/minisat2
	doins -r mtl || die
	rm -f "${ED}"/usr/include/minisat2/mtl/config.mk || die
	doins core/Solver.h simp/SimpSolver.h || die

	insinto /usr/include/minisat2/core
	doins core/SolverTypes.h || die

	insinto /usr/include/minisat2/utils
	doins utils/*.h || die

	newbin ${mydir}/${PN}_${myext} ${PN} || die
	newlib.a ${mydir}/lib${PN}_${myext}.a lib${PN}.a || die

	dodoc README doc/ReleaseNotes-2.2.0.txt || die
	if use doc; then
		dodoc "${DISTDIR}"/MiniSat.pdf || die
	fi
}
