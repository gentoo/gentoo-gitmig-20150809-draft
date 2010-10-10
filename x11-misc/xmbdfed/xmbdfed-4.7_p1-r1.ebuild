# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmbdfed/xmbdfed-4.7_p1-r1.ebuild,v 1.6 2010/10/10 21:10:50 ulm Exp $

EAPI=2
MY_P=${P/_p*}
inherit eutils multilib toolchain-funcs

DESCRIPTION="BDF font editor for X"
SRC_URI="http://clr.nmsu.edu/~mleisher/${MY_P}.tar.bz2
	http://clr.nmsu.edu/~mleisher/${P/_p/-patch}"
HOMEPAGE="http://clr.nmsu.edu/~mleisher/xmbdfed.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RESTRICT="test"

DEPEND=">=x11-libs/openmotif-2.3.0-r1:0
	media-libs/freetype"
RDEPEND="${DEPEND}
	media-fonts/font-adobe-75dpi
	media-fonts/font-alias
	media-fonts/font-misc-misc"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${DISTDIR}"/${P/_p/-patch} \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-gentoo.patch
	sed -i -e "/^LIBS/s:/usr/lib:/usr/$(get_libdir):" Makefile || die
	sed -i -e "s:getline:get_line:g" bdfgname.c || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin xmbdfed || die "dobin failed"
	newman xmbdfed.man xmbdfed.1
	dodoc CHANGES README xmbdfedrc
}
