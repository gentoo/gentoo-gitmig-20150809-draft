# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gfan/gfan-0.5.ebuild,v 1.6 2011/12/14 09:00:45 phajdan.jr Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="computes Groebner fans and tropical varities"
HOMEPAGE="http://www.math.tu-berlin.de/~jensen/software/gfan/gfan.html"
SRC_URI="http://www.math.tu-berlin.de/~jensen/software/gfan/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/gmp[cxx]
	sci-libs/cddlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}${PV}/"

src_prepare () {
	sed -i -e "s/-O2/${CXXFLAGS}/" \
		-e "/GPROFFLAG =/d" \
		-e "s/g++/$(tc-getCXX)/" \
		-e "s/\$(CCLINKER)/& \$(LDFLAGS)/" Makefile || die
}

src_install() {
	emake PREFIX="${ED}/usr" install || die "emake install failed"
}
