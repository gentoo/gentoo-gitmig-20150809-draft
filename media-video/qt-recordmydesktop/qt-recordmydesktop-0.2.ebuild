# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qt-recordmydesktop/qt-recordmydesktop-0.2.ebuild,v 1.1 2007/07/26 16:02:03 aballier Exp $

inherit qt4

DESCRIPTION="QT4 interface for RecordMyDesktop"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(qt4_min_version 4.2)
	>=dev-python/PyQt4-4.1
	>=media-video/recordmydesktop-0.3.5"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README AUTHORS ChangeLog
}
