# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/muParser/muParser-1.34.ebuild,v 1.4 2011/12/16 16:42:22 ago Exp $

EAPI=4

inherit eutils

MY_PN=${PN/P/p}
MY_P=${MY_PN}_v${PV/./}

DESCRIPTION="Library for parsing mathematical expressions"
HOMEPAGE="http://muparser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc test"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.32-build.patch \
		"${FILESDIR}"/${PN}-1.32-parallel-build.patch
	sed \
		-e 's:-O2::g' \
		-i configure || die
}

src_configure() {
	econf $(use_enable test samples)
}

src_test() {
	cat > test.sh <<- EOFTEST
	LD_LIBRARY_PATH=${S}/lib samples/example1/example1 <<- EOF
	quit
	EOF
	EOFTEST
	sh ./test.sh || die "test failed"
}

src_install() {
	default
	dodoc Changes.txt  Credits.txt || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r docs/html || die
	fi
}
