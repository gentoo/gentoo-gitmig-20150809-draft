# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kapow/kapow-1.3.2.ebuild,v 1.1 2010/07/02 08:04:19 ssuominen Exp $

EAPI=2
inherit qt4-r2

DESCRIPTION="A punch clock program designed to easily keep track of your hours"
HOMEPAGE="http://gottcode.org/kapow/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

src_prepare() {
	sed -i \
		-e '/PREFIX/s:/usr/local:/usr:' \
		kapow.pro || die

	qt4-r2_src_prepare
}

DOCS="ChangeLog README"
