# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmenc15/kmenc15-0.04.ebuild,v 1.4 2006/11/09 17:30:12 aballier Exp $

inherit eutils kde

DESCRIPTION="Kmenc15 is an advanced Qt/KDE MEncoder frontend"
HOMEPAGE="http://kmenc15.sourceforge.net"
SRC_URI="mirror://sourceforge/kmenc15/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
DEPEND="media-video/mplayer"
IUSE=""

src_compile() {
	epatch "${FILESDIR}/${PN}-wcondiff.diff"
	emake || die
}

src_install() {
	dobin kmenc15
	dodoc AUTHORS README
}

need-kde 3.3
