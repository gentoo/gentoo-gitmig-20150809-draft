# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmbdfed/xmbdfed-4.7_p1.ebuild,v 1.10 2010/10/10 21:10:50 ulm Exp $

EAPI=1
inherit eutils toolchain-funcs
MY_P=${P/_p*}

DESCRIPTION="BDF font editor for X"
SRC_URI="http://clr.nmsu.edu/~mleisher/${MY_P}.tar.bz2
	http://clr.nmsu.edu/~mleisher/${P/_p/-patch}"
HOMEPAGE="http://clr.nmsu.edu/~mleisher/xmbdfed.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=x11-libs/openmotif-2.3.0-r1:0
	media-libs/freetype"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd "${S}"
	epatch "${DISTDIR}/${P/_p/-patch}"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	sed -e 's:\(-o xmbdfed \): $(LDFLAGS) \1:' -i Makefile || die
}

src_compile() {
	# There's no ./configure in xmbdfed, so perform the make by manually
	# specifying the correct options for Gentoo.
	local flags=""
	local incs=""
	local libs="-lXm -lXpm -lXmu -lXt -lXext -lX11 -lSM -lICE"

	flags="FTYPE_DEFS=\"-DHAVE_FREETYPE\""
	incs="${incs} `freetype-config --cflags`"
	libs="${libs} `freetype-config --libs`"

	make CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		${flags} \
		LDFLAGS="${LDFLAGS}" \
		INCS="${incs}" \
		LIBS="${libs}" || die
}

src_install() {
	dobin xmbdfed || die
	newman xmbdfed.man xmbdfed.1
	dodoc CHANGES README xmbdfedrc
}
