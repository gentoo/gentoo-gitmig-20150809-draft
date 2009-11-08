# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/piedock/piedock-0.2.3.ebuild,v 1.1 2009/11/08 15:00:12 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

MY_PN=PieDock
MY_P=${MY_PN}-${PV}

DESCRIPTION="A little bit like the famous OS X dock but in shape of a pie menu"
HOMEPAGE="http://www.markusfisch.de/?PieDock"
SRC_URI="http://www.markusfisch.de/downloads/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng
	x11-libs/libX11
	x11-libs/libXft
	media-libs/freetype:2"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e 's:$(CXX) -o:$(CXX) $(LDFLAGS) -o:' \
		{.,utils}/Makefile || die
}

src_compile() {
	emake CXX="$(tc-getCXX)" FLAGS="${CXXFLAGS} -I/usr/include/freetype2" || die
	emake -C utils CXX="$(tc-getCXX)" FLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin ${MY_PN} utils/${MY_PN}Utils || die
	insinto /usr/share/${MY_PN}
	doins res/*.png || die
	dodoc res/*.sample || die
}
