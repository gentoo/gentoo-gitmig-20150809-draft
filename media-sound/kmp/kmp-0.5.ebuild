# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmp/kmp-0.5.ebuild,v 1.6 2009/12/28 15:44:55 ssuominen Exp $

EAPI=2
inherit eutils qt3

DESCRIPTION="An MPD client that uses Qt"
HOMEPAGE="http://www.threadbox.net/pages/kmp"
SRC_URI="http://www.threadbox.net/code/files/kmp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="x11-libs/qt:3"

S=${WORKDIR}/${PN}

src_configure() {
	echo QMAKE_CFLAGS_RELEASE=${CFLAGS} >> kmp.pro
	echo QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} >> kmp.pro
	ac_moc=${QTDIR}/bin/moc ac_uic=${QTDIR}/bin/uic ac_qmake=${QTDIR}/bin/qmake econf
}

src_install() {
	dobin kmp || die
	dodoc README
	newicon pics/icon.png kmp.png
	make_desktop_entry kmp KMP kmp "KDE;Qt;AudioVideo"
}
