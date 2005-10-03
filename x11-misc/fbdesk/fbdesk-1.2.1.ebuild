# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbdesk/fbdesk-1.2.1.ebuild,v 1.5 2005/10/03 12:15:00 ka0ttic Exp $

DESCRIPTION="fluxbox-util application that creates and manage icons on your Fluxbox desktop"
HOMEPAGE="http://www.fluxbox.org/fbdesk/"
SRC_URI="http://www.fluxbox.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ia64 ~amd64"
IUSE="debug png"

DEPEND="virtual/x11
	png? ( media-libs/libpng )"

src_compile() {
	econf \
	    $(use_enable debug) \
	    $(use_enable png) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog README
}
