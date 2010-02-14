# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/muParser/muParser-1.32.ebuild,v 1.1 2010/02/14 20:45:26 pva Exp $

EAPI=2
inherit eutils

MY_PN=${PN/P/p}
MY_P=${MY_PN}_v${PV/./}
DESCRIPTION="Library for parsing mathematical expressions"
HOMEPAGE="http://muparser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc test"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# fix destdir and respect cxxflags
	# cant really use autotools cause muparser use bakefile
	# and too lasy to make an ebuild for it.
	epatch "${FILESDIR}"/${P}-build.patch
}

src_configure() {
	econf $(use_enable test samples)
}

src_test() {
	cat > test.sh <<-EOFTEST
	LD_LIBRARY_PATH=${S}/lib samples/example1/example1 << EOF
	quit
	EOF
	EOFTEST
	sh ./test.sh || die "test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Changes.txt  Credits.txt || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r docs/html || die
	fi
}
