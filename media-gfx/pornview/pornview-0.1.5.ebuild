# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pornview/pornview-0.1.5.ebuild,v 1.7 2004/07/14 17:50:30 agriffis Exp $

DESCRIPTION="Image viewer/manager with optional support for MPEG movies."
HOMEPAGE="http://pornview.sourceforge.net"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	>=media-libs/gdk-pixbuf-0.16
	=x11-libs/gtk+-1.2*
	mpeg? ( =media-libs/xine-lib-0.9* )"

#From README mplayer is broken
#	avi? ( media-video/mplayer )"

SLOT="0"
KEYWORDS="x86 ppc"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE="mpeg"

src_compile() {
	local myflags=""
#	use avi && myflags="--enable-mplayer"
	use mpeg && myflags="--enable-xine"
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

	einfo "Sorry, mplayer support is broken so we had to disable it"
	einfo "Please do not open a bug even if this is fixed by"
	einfo "the pornview developer himself"

}
