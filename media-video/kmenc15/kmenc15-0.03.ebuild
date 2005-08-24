# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmenc15/kmenc15-0.03.ebuild,v 1.2 2005/08/24 21:21:38 trapni Exp $

inherit eutils kde

DESCRIPTION="Kmenc15 is an advanced Qt/KDE MEncoder frontend"
HOMEPAGE="http://kmenc15.sourceforge.net"
SRC_URI="mirror://sourceforge/kmenc15/${P}.tar.bz2"
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
