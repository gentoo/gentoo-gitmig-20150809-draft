# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmbdfed/xmbdfed-4.7_p1.ebuild,v 1.4 2004/09/02 22:49:41 pvdabeel Exp $

inherit eutils
MY_P=${P/_p*}

DESCRIPTION="BDF font editor for X"
SRC_URI="http://clr.nmsu.edu/~mleisher/${MY_P}.tar.bz2
	http://clr.nmsu.edu/~mleisher/${P/_p/-patch}"
HOMEPAGE="http://clr.nmsu.edu/~mleisher/xmbdfed.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ppc"
IUSE="truetype"

DEPEND="virtual/x11
	>=x11-libs/openmotif-2.1.30
	truetype? ( media-libs/freetype )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/${P/_p/-patch}
}

src_compile() {
	# There's no ./configure in xmbdfed, so perform the make by manually
	# specifying the correct options for Gentoo.

	local flags=""
	local incs="-I/usr/X11R6/include"
	local libs="-L/usr/X11R6/lib -lXm -lXpm -lXmu -lXt -lXext -lX11 -lSM -lICE"

	if use truetype ; then
		flags="FTYPE_DEFS=\"-DHAVE_FREETYPE\""
		incs="${incs} `freetype-config --cflags`"
		libs="${libs} `freetype-config --libs`"
	fi

	make CFLAGS="${CFLAGS}" ${flags} \
		INCS="${incs}" \
		LIBS="${libs}" || die
}

src_install() {
	dobin xmbdfed
	newman xmbdfed.man xmbdfed.1
	dodoc CHANGES COPYRIGHTS INSTALL README xmbdfedrc
}
