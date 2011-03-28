# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mvc/mvc-0.8.7.ebuild,v 1.6 2011/03/28 21:30:17 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="Motion Video Capture, text mode v4l video capture program with motion detection feature"
HOMEPAGE="http://modesto.sourceforge.net/piave/index.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="virtual/jpeg
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

doecho() {
	echo "$@"
	"$@"
}

src_compile() {
	doecho $(tc-getCC) \
		${CFLAGS} -DHAVE_JPEG -DHAVE_PNG $(pkg-config --cflags libpng) \
		${LDFLAGS} -o mvc \
		mvc.c \
		-ljpeg $(pkg-config --libs libpng)
}

src_install() {
	dobin mvc || die
	doman mvc.1
	dodoc ChangeLog README TODO NEWS
}
