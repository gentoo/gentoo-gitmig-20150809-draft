# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tbb/tbb-3.0.035.ebuild,v 1.1 2010/07/19 15:43:09 bicatali Exp $

EAPI=2
inherit eutils versionator toolchain-funcs alternatives
#  url number
MYU="78/155"
# release update
MYR="%20update%20"1

PV1="$(get_version_component_range 1)"
PV2="$(get_version_component_range 2)"
PV3="$(get_version_component_range 3)"
MYP="${PN}${PV1}${PV2}_${PV3}oss"

DESCRIPTION="High level abstract threading library"
HOMEPAGE="http://www.threadingbuildingblocks.org/"
SRC_URI="http://www.threadingbuildingblocks.org/uploads/${MYU}/${PV1}.${PV2}${MYR}/${MYP}_src.tgz"
LICENSE="GPL-2-with-exceptions"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples"

DEPEND="!<=dev-cpp/tbb-2.1.016"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-tests.patch
	sed -i \
		-e "s/-O2/${CXXFLAGS}/g" \
		build/*.inc \
		|| die
}

src_compile() {
	if [[ $(tc-getCXX) == *g++ ]]; then
		myconf="compiler=gcc"
	elif [[ $(tc-getCXX) == *ic*c ]]; then
		myconf="compiler=icc"
	fi
	# from the Makefile, split debug
	cd src
	emake ${myconf} tbb_release tbbmalloc_release || die "emake failed"
	if use debug || use examples; then
		emake ${myconf} tbb_debug tbbmalloc_debug || die "emake debug failed"
	fi
}

src_test() {
	cd src
	emake -j1 ${myconf} test_release || die "emake test failed"
	if use debug || use examples; then
		emake ${myconf} test_debug tbbmalloc_test_debug || die "emake test debug failed"
	fi

}

src_install(){
	for l in $(find build -name lib\*.so.\*); do
		dolib.so ${l} || die
		local bl=$(basename ${l})
		dosym ${bl} /usr/$(get_libdir)/${bl%.*}
	done
	insinto /usr
	doins -r include || die

	dodoc README CHANGES doc/Release_Notes.txt
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r doc/html || die
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples/build
		doins build/*.inc || die
		insinto /usr/share/doc/${PF}/examples
		doins -r examples || die
	fi
}
