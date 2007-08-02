# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xwrits/xwrits-2.21.ebuild,v 1.17 2007/08/02 13:44:55 uberlord Exp $

DESCRIPTION="Xwrits reminds you to take wrist breaks, which will hopefully help you prevent repetitive stress injury."
HOMEPAGE="http://www.lcdf.org/xwrits/"
SRC_URI="http://www.lcdf.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc GESTURES NEWS README
}
