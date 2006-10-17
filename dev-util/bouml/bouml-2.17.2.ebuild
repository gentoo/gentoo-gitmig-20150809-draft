# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bouml/bouml-2.17.2.ebuild,v 1.1 2006/10/17 18:37:44 flameeyes Exp $

inherit qt3 toolchain-funcs multilib eutils

MY_P="${PN}_${PV}"

DESCRIPTION="Free UML 2 tool box with C++, Java and Idl code generation"
HOMEPAGE="http://bouml.free.fr/"
SRC_URI="http://bouml.free.fr/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="$(qt_min_version 3)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake QMAKE="${QTDIR}/bin/qmake" \
		CC="$(tc-getCC) ${CFLAGS}" \
		CXX="$(tc-getCXX) ${CXXFLAGS}" \
		LINK="$(tc-getCXX) ${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake BOUML_LIB="/usr/$(get_libdir)/bouml" DESTDIR="${D}" install || die "emake install failed"
}
