# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/klvemkdvd/klvemkdvd-0.4.ebuild,v 1.5 2004/07/14 21:50:13 agriffis Exp $

inherit kde

DESCRIPTION="DVD filesystem Builder"
HOMEPAGE="http://lvempeg.sourceforge.net"
SRC_URI="http://heanet.dl.sourceforge.net/sourceforge/lvempeg/klvemkdvd-0.4.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=media-video/lve-040322
	>=x11-libs/qt-3.3.0-r1
	>=kde-base/kdebase-3.2.1
	>=media-video/dvdauthor-0.5.0
	>=app-cdr/dvd+rw-tools-5.13.4.7.4
	>=media-video/mplayer-0.92-r1"

src_install() {
	cd ${WORKDIR}/lveripdvd
	make || die
	einstall || die
}
