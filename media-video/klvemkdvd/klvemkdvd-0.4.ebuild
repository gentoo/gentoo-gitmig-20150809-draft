# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/klvemkdvd/klvemkdvd-0.4.ebuild,v 1.9 2005/07/02 13:42:13 flameeyes Exp $

inherit kde eutils

DESCRIPTION="DVD filesystem Builder"
HOMEPAGE="http://lvempeg.sourceforge.net"
SRC_URI="mirror://sourceforge/lvempeg/klvemkdvd-0.4.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=media-video/lve-040322
	>=media-video/dvdauthor-0.5.0
	>=app-cdr/dvd+rw-tools-5.13.4.7.4
	>=media-video/mplayer-0.92-r1"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-gcc3.4.patch
}


src_install() {
	cd ${WORKDIR}/lveripdvd
	make || die
	einstall || die
}

