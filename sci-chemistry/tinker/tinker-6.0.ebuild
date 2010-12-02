# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/tinker/tinker-6.0.ebuild,v 1.5 2010/12/02 10:51:39 jlec Exp $

EAPI="2"
FORTRAN="gfortran ifc"

inherit fortran java-pkg-opt-2 toolchain-funcs

DESCRIPTION="Molecular modeling package that includes force fields, such as AMBER and CHARMM"
HOMEPAGE="http://dasher.wustl.edu/tinker/"
SRC_URI="http://dasher.wustl.edu/${PN}/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="Tinker"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

DEPEND=">=virtual/jdk-1.6"
RDEPEND="
	dev-libs/maloc
	!dev-util/diffuse
	>=virtual/jre-1.6"
RESTRICT="mirror"

S="${WORKDIR}"/tinker/source

pkg_setup() {
	fortran_pkg_setup
	java-pkg-opt-2_pkg_setup
}

src_compile() {
	local javalib=
	for i in $(java-config -g LDPATH | sed 's|:| |g'); do
		[[ -f ${i}/libjvm.so ]] && javalib=${i}
	done

	emake \
		-f ../make/Makefile \
		F77="${FORTRANC}" \
		CC="$(tc-getCC) -c" \
		F77FLAGS=-c \
		OPTFLAGS="${FFLAGS}" \
		LINKFLAGS="${LDFLAGS} -Wl,-rpath ${javalib}" \
		INCLUDEDIR="$(java-pkg_get-jni-cflags) -I${EPREFIX}/usr/include" \
		LIBS="-lmaloc -L${javalib} -ljvm" \
		|| die

	mkdir "${S}"/../bin || die

	emake \
		-f ../make/Makefile \
		BINDIR="${S}"/../bin \
		rename || die
}

src_test() {
	cd "${WORKDIR}"/tinker/test/
	for test in *.run; do
		einfo "Testing ${test} ..."
		bash ${test} || die
	done
}

src_install() {
	dobin "${WORKDIR}"/${PN}/perl/mdavg "${WORKDIR}"/${PN}/bin/* || die

	insinto /usr/share/${PN}/
	doins -r "${WORKDIR}"/${PN}/params || die

	dodoc \
		"${WORKDIR}"/${PN}/doc/{*.txt,announce/release-*,*.pdf,0README} || die

	if use examples; then
		insinto /usr/share/${P}
		doins -r "${WORKDIR}"/${PN}/example || die

		doins -r "${WORKDIR}"/${PN}/test || die
	fi

}
