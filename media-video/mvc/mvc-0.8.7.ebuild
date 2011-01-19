# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mvc/mvc-0.8.7.ebuild,v 1.5 2011/01/19 20:39:41 spatz Exp $

inherit toolchain-funcs

DESCRIPTION="Motion Video Capture, text mode v4l video capture program with motion detection feature"
HOMEPAGE="http://modesto.sourceforge.net/piave/index.html"
SRC_URI="http://www.turbolinux.com.cn/~merlin/mvc/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

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
	dobin mvc
	doman mvc.1
	dodoc ChangeLog README TODO NEWS
}
