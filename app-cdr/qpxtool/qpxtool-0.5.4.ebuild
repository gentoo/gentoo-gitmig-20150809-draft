# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qpxtool/qpxtool-0.5.4.ebuild,v 1.1 2006/07/17 23:56:19 vapier Exp $

inherit kde-functions qt3

DESCRIPTION="cd/dvd quality checker for a variety of drives"
HOMEPAGE="http://qpxtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/qpxtool/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_compile() {
	local d
	for d in qpxtool pxcontrol ; do
		cd "${S}"/${d}
		"${QTDIR}"/bin/qmake -project || die "qmake ${d} -project failed"
		"${QTDIR}"/bin/qmake ${d}.pro || die "qmake ${d} failed"
		emake || die "emake ${d} failed"
	done
}

src_install() {
	dobin qpxtool/qpxtool pxcontrol/pxcontrol || die
	dodoc qpxtool/{AUTHORS,ChangeLog,README,TODO}
}
