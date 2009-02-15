# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmenc15/kmenc15-0.04-r1.ebuild,v 1.1 2009/02/15 17:17:57 carlo Exp $

inherit eutils kde-functions

DESCRIPTION="Kmenc15 is an advanced Qt/KDE MEncoder frontend."
HOMEPAGE="http://kmenc15.sourceforge.net"
SRC_URI="mirror://sourceforge/kmenc15/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="media-video/mplayer"
need-kde 3.5

src_compile() {
	epatch "${FILESDIR}/${PN}-wcondiff.diff"
	emake || die
}

src_install() {
	dobin kmenc15
	dodoc AUTHORS README
}
