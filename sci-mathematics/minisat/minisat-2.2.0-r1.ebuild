# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/minisat/minisat-2.2.0-r1.ebuild,v 1.1 2011/04/09 22:31:01 nerdboy Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Small yet efficient SAT solver with reference paper."
HOMEPAGE="http://minisat.se/Main.html"
SRC_URI="http://minisat.se/downloads/${P}.tar.gz
	doc? ( http://minisat.se/downloads/MiniSat.pdf )"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="MIT"

IUSE="debug doc extended-solver prof"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	if use debug; then
		myconf="d"
	elif use prof; then
		myconf="p"
	else
		myconf="r"
	fi

	sed -i -e "s|-O3|${CFLAGS} ${LDFLAGS}|" mtl/template.mk
}

src_compile() {
	tc-export CXX
	export MROOT="${S}"

	if use extended-solver; then
		cd simp
	else
		cd core
	fi

	gmake "$myconf" || die "make failed"
	LIB="${PN}" gmake lib"$myconf" || die "make lib failed"
	cd "${S}"
}

src_install() {
	insinto /usr/include
	doins -r mtl
	doins utils/Options.h utils/System.h core/Solver.h core/SolverTypes.h

	# somewhat brute-force, but so is the build setup...
	if use extended-solver; then
		cd simp
		doins SimpSolver.h
	else
		cd core
	fi

	if use debug; then
		newbin ${PN}_debug ${PN} || die
		newlib.a lib${PN}_debug.a lib${PN}.a || die
	elif use prof; then
		newbin ${PN}_profile ${PN} || die
		newlib.a lib${PN}_profile.a lib${PN}.a || die
	else
		newbin ${PN}_release ${PN} || die
		newlib.a lib${PN}_release.a lib${PN}.a || die
	fi
	cd "${S}"

	dodoc README doc/ReleaseNotes-2.2.0.txt
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/MiniSat.pdf
	fi
}
