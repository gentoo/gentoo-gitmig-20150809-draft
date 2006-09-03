# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bouml/bouml-2.16.ebuild,v 1.1 2006/09/03 16:01:35 flameeyes Exp $

inherit qt3 toolchain-funcs multilib eutils

MY_P="${PN}_${PV}"

DESCRIPTION="Free UML 2 tool box with C++, Java and Idl code generation"
HOMEPAGE="http://bouml.free.fr/"
SRC_URI="http://bouml.free.fr/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="$(qt_min_version 3)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	sed -i -e '/^MAKE/d' "${S}/Makefile"
}

src_compile() {
	cd "${S}"
	local sourcedirs=$(find . -name '*.pro' -not -name 'gpro.pro' -exec dirname {} \;)

	for dir in ${sourcedirs}; do
		pushd "${dir}"
		"${QTDIR}/bin/qmake" QMAKE="${QTDIR}/bin/qmake"
		emake \
			CC="$(tc-getCC) ${CFLAGS}" \
			CXX="$(tc-getCXX) ${CXXFLAGS}" \
			LINK="$(tc-getCXX)" \
			LFLAGS="${LDFLAGS}" || die "emake failed"
		popd
	done
}

src_install() {
	# The provided wrapper is bogus, just install it in temporary directory and then remove it
	emake BOUML_LIB="${D}/usr/$(get_libdir)/bouml" BOUML_DIR="${T}" install

	# We fake the PATH change with LD_LIBRARY_PATH change, to follow the original wrapper
	make_wrapper bouml "/usr/$(get_libdir)/bouml/bouml" . "/usr/$(get_libdir)/bouml"
	sed -i -e 's:LD_LIBRARY_PATH:PATH:g' "${D}/usr/bin/bouml"

	make_desktop_entry bouml "BOUML" bouml
}
