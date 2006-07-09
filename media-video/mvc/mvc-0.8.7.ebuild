# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mvc/mvc-0.8.7.ebuild,v 1.3 2006/07/09 20:07:27 flameeyes Exp $

inherit toolchain-funcs

DESCRIPTION="Motion Video Capture, text mode v4l video capture program with motion detection feature"
HOMEPAGE="http://modesto.sourceforge.net/piave/index.html"
SRC_URI="http://www.turbolinux.com.cn/~merlin/mvc/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

RDEPEND="media-libs/jpeg
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

doecho() {
	echo "$@"
	exec "$@"
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
