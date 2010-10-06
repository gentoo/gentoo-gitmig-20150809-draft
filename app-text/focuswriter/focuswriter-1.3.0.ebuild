# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/focuswriter/focuswriter-1.3.0.ebuild,v 1.1 2010/10/06 20:38:08 chiiph Exp $

EAPI=3
inherit qt4-r2

DESCRIPTION="A fullscreen and distraction-free word processor"
HOMEPAGE="http://gottcode.org/focuswriter/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	app-text/hunspell"
RDEPEND="${DEPEND}"

DOCS="ChangeLog README"

src_prepare() {
	sed -i -e '/PREFIX/s:/usr/local:/usr:' ${PN}.pro || die
	qt4-r2_src_prepare
}
