# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/znotes/znotes-0.3.6.ebuild,v 1.2 2010/01/07 11:55:30 hwoarang Exp $

EAPI="2"
inherit qt4-r2

DESCRIPTION="Simple Notes"
HOMEPAGE="http://www.qt-apps.org/content/show.php/zNotes?content=113117"
SRC_URI="http://www.qt-apps.org/CONTENT/content-files/113117-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_configure() {
	lrelease znotes.pro || die "lrelease failed"
	qt4-r2_src_configure
}
