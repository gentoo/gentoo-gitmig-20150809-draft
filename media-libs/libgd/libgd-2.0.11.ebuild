# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-2.0.11.ebuild,v 1.1 2003/02/23 07:18:03 vapier Exp $

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz"
HOMEPAGE="http://www.boutell.com/gd/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="~x86"
IUSE="X pic"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.7
	>=media-libs/freetype-2.0.9
	X? ( virtual/x11 )"

src_compile() {
	econf \
		--with-gnu-ld \
		`use_with pic` \
		`use_with X x` \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc README*
	dohtml index.html demoin.png
}
