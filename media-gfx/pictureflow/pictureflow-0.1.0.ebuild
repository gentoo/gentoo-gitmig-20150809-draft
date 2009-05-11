# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pictureflow/pictureflow-0.1.0.ebuild,v 1.2 2009/05/11 14:24:54 fmccor Exp $

EAPI="2"
inherit qt4

DESCRIPTION="Qt widget to display images with animated transition effect"
HOMEPAGE="http://www.qt-apps.org/content/show.php/PictureFlow?content=75348"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P}/${PN}-qt"

src_configure() {
	eqmake4
}

src_install() {
	dobin ${PN} || die "dobin failed"
	cd ..
	dodoc ChangeLog || die "dodoc failed"
}
