# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qgo/qgo-1.0.4.2.ebuild,v 1.1 2006/03/03 23:57:55 mr_bones_ Exp $

inherit kde-functions eutils

DESCRIPTION="A c++/qt go client and sgf editor"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI="mirror://sourceforge/qgo/${PN}-${PV%.*}-r${PV##*.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

need-qt 3

S=${WORKDIR}/${PN}-${PV%.*}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
