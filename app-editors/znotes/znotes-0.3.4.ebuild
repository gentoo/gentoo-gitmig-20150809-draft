# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/znotes/znotes-0.3.4.ebuild,v 1.2 2009/11/04 19:25:02 yngwin Exp $

EAPI="2"
inherit qt4

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
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"
}
