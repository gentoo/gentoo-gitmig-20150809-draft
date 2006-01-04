# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qpxtool/qpxtool-0.4.2.ebuild,v 1.1 2006/01/04 05:03:04 vapier Exp $

inherit kde-functions

DESCRIPTION="cd/dvd quality check for Plextor drives"
HOMEPAGE="http://qpxtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/$PN/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
need-qt 3

src_compile() {
	qmake -project || die "qmake -project failed"
	qmake qpxtool-${PV}.pro || die "qmake qpxtool failed"
	emake || die "emake failed"
}

src_install() {
	newbin qpxtool-${PV} qpxtool || die "dobin failed"
	dodoc ChangeLog || die "dodoc failed"
}
