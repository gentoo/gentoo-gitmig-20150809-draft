# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/znotes/znotes-0.4.5.ebuild,v 1.1 2012/01/30 07:49:35 johu Exp $

EAPI=4
inherit qt4-r2

DESCRIPTION="Simple Notes"
HOMEPAGE="http://znotes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

DOCS="CHANGELOG THANKS"

src_configure() {
	lrelease znotes.pro || die "lrelease failed"
	qt4-r2_src_configure
}
