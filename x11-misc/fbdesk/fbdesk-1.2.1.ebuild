# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbdesk/fbdesk-1.2.1.ebuild,v 1.3 2005/04/01 19:05:10 agriffis Exp $

inherit eutils gcc

DESCRIPTION="fluxbox-util application that creates and manage icons on your Fluxbox desktop"
HOMEPAGE="http://www.fluxbox.org/fbdesk/"
SRC_URI="http://www.fluxbox.org/download/${P}.tar.gz"
IUSE="debug png"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ia64 ~amd64"

DEPEND="media-libs/libpng
	virtual/x11
	png? ( media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf \
	    `use_enable debug` \
	    `use_enable png` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README
}
