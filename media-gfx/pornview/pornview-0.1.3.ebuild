# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pornview/pornview-0.1.3.ebuild,v 1.1 2002/12/10 19:29:05 mholzer Exp $

DESCRIPTION="Image viewer/manager with optional support for MPEG movies."
HOMEPAGE="http://pornview.sourceforge.net"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	>=media-libs/gdk-pixbuf-0.16
	=x11-libs/gtk+-1.2*
	mpeg? ( media-libs/xine-lib )
	avi? ( media-video/mplayer )"

SLOT="0"
KEYWORDS="~x86"
SRC_URI="mirror://sourceforge/pornview/${P}.tar.gz"
IUSE="mpeg"

S="${WORKDIR}/${P}"

src_compile() {
	local myflags=""
	use mpeg && myflags="${myflags} --enable-xine"
	use avi && myflags="${myflags} --enable-mplayer"
	./configure $myflags\
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
