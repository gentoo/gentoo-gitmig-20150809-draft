# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbdesk/fbdesk-1.1.2.ebuild,v 1.2 2003/02/13 17:12:35 vapier Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="FbDesk is a fluxbox-util application that creates and manage icons on your Fluxbox desktop."
HOMEPAGE="http://www.fluxbox.org/fbdesk/"
SRC_URI="http://www.fluxbox.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-libs/libpng
	media-libs/xpm
	virtual/x11"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
