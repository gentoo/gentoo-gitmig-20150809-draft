# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmbdfed/xmbdfed-4.7_p1-r1.ebuild,v 1.1 2009/01/01 01:33:50 matsuu Exp $

inherit eutils multilib toolchain-funcs

MY_P="${P/_p*}"
DESCRIPTION="BDF font editor for X"
SRC_URI="http://clr.nmsu.edu/~mleisher/${MY_P}.tar.bz2
	http://clr.nmsu.edu/~mleisher/${P/_p/-patch}"
HOMEPAGE="http://clr.nmsu.edu/~mleisher/xmbdfed.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RESTRICT="test"

DEPEND=">=x11-libs/openmotif-2.3.0-r1
	media-libs/freetype"
RDEPEND="${DEPEND}
	media-fonts/font-adobe-75dpi
	media-fonts/font-alias
	media-fonts/font-misc-misc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}/${P/_p/-patch}"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	sed -i -e "/^LIBS/s:/usr/lib:/usr/$(get_libdir):" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin xmbdfed || die
	newman xmbdfed.man xmbdfed.1
	dodoc CHANGES README xmbdfedrc
}
