# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-2.0.11-r1.ebuild,v 1.1 2003/03/20 13:59:36 vladimir Exp $

inherit eutils libtool

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz"
HOMEPAGE="http://www.boutell.com/gd/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~hppa ~arm ~alpha"
IUSE="X gif pic"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=media-libs/freetype-2.1.2
	X? ( virtual/x11 )"

src_unpack() {

	unpack ${A}
	cd ${S}

	elibtoolize

	if [ -n "`use gif`" ]
	then
		epatch ${FILESDIR}/${MY_P}-gif-support.patch.bz2
	fi

}

src_compile() {

	econf \
		--with-gnu-ld \
		`use_with X x` \
		|| die
	emake || die

}

src_install() {

	emake DESTDIR=${D} install || die
	dodoc COPYING INSTALL README*
	dohtml -r ./

}
