# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmbdfed/xmbdfed-4.5.ebuild,v 1.5 2004/01/25 22:31:44 pyrania Exp $

DESCRIPTION="BDF font editor for X"
SRC_URI="http://clr.nmsu.edu/~mleisher/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"
HOMEPAGE="http://clr.nmsu.edu/~mleisher/xmbdfed.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE="truetype"

DEPEND="virtual/x11
	>=x11-libs/openmotif-2.1.30
	truetype? ( =media-libs/freetype-1.3* )"

# The xmbdfed-4.5-gentoo.diff includes patch 1 for version 4.5.  The
# author hasn't distributed a new numbered release yet, so I've
# blended the patch in with a small include file fix needed for the
# Gentoo install of freetype.
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
}

src_compile() {
	# There's no ./configure in xmbdfed, so perform the make by manually
	# specifying the correct options for Gentoo.

	local flags=""
	local incs="-I/usr/X11R6/include"
	local libs="-L/usr/X11R6/lib -lXm -lXpm -lXmu -lXt -lXext -lX11 -lSM -lICE"

	if [ `use truetype` ] ; then
		flags="FTYPE_DEFS=\"-DHAVE_FREETYPE\""
		incs="${incs} -I/usr/include/freetype"
		libs="${libs} -lttf"
	fi

	make CFLAGS="${CFLAGS}" ${flags} \
		INCS="${incs}" \
		LIBS="${libs}"
}

src_install() {
	dobin xmbdfed
	newman xmbdfed.man xmbdfed.1
	dodoc CHANGES COPYRIGHTS INSTALL README xmbdfedrc
}
