# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gd/gd-2.0.28.ebuild,v 1.1 2004/07/22 19:52:39 vapier Exp $

DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://www.boutell.com/gd/"
SRC_URI="http://www.boutell.com/gd/http/${P}.tar.gz"

LICENSE="as-is | BSD"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE="jpeg png X truetype"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( >=media-libs/libpng-1.2.5 sys-libs/zlib )
	truetype? ( >=media-libs/freetype-2.1.5 )
	X? ( virtual/x11 )"

src_compile() {
	econf \
		`use_with png` \
		`use_with truetype freetype` \
		`use_with jpeg` \
		`use_with X xpm` \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc INSTALL README*
	dohtml -r ./
}
