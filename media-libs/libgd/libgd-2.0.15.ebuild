# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-2.0.15.ebuild,v 1.1 2003/06/17 19:20:25 vapier Exp $

inherit eutils libtool

MY_P=${P/lib/}
GIF_PATCH=patch_gd${PV}_gif_030616
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz
	gif? ( http://downloads.rhyme.com.au/gd/${GIF_PATCH}.gz )"
HOMEPAGE="http://www.boutell.com/gd/ http://www.rime.com.au/gd/"

SLOT="2"
LICENSE="as-is | BSD"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~hppa ~arm ~alpha"
IUSE="X gif"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=media-libs/freetype-2.1.2
	X? ( virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}
	elibtoolize
	[ -n "`use gif`" ] && epatch ${WORKDIR}/${GIF_PATCH}
}

src_compile() {
	econf `use_with X x` || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc INSTALL README*
	dohtml -r ./
}
