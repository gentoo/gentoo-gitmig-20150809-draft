# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmenc15/kmenc15-0.03.ebuild,v 1.1 2005/03/15 00:17:30 trapni Exp $

inherit eutils kde

DESCRIPTION="Kmenc15 is an advanced Qt/KDE MEncoder frontend"
HOMEPAGE="http://kmenc15.sourceforge.net"
SRC_URI="http://dividedsky.net/%7Eods15/kmenc15/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="media-video/mplayer"
IUSE=""

src_compile() {
	emake || die
}

src_install() {
	dobin kmenc15
	dodoc AUTHORS COPYING README
}

need-kde 3.3
