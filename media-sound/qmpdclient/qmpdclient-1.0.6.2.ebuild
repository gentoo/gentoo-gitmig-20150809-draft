# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-1.0.6.2.ebuild,v 1.1 2006/10/21 23:36:54 ticho Exp $

inherit eutils

DESCRIPTION="An easy to use MPD client written in Qt 4.1"
HOMEPAGE="http://havtknut.tihlde.org/qmpdclient"
SRC_URI="http://havtknut.tihlde.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-4.1"

src_compile() {
	./configure || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dodoc README AUTHORS THANKSTO Changelog
	insinto /usr/share/pixmaps
	doins icons/qmpdclient{16,22,32,64,128}.png
	dobin qmpdclient

	make_desktop_entry qmpdclient "QMPDClient" qmpdclient64.png "KDE;Qt;AudioVideo"
}
