# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmp/kmp-0.01.ebuild,v 1.4 2004/09/14 07:58:30 eradicator Exp $

inherit eutils kde-functions

need-qt 3

DESCRIPTION="An MPD client that uses Qt"
HOMEPAGE="http://www.threadbox.net/kmp.php"
SRC_URI="http://www.threadbox.net/code/files/kmp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/kmp-0.01-gcc34.patch
}

src_compile() {
	echo QMAKE_CFLAGS_RELEASE=${CFLAGS} >> kmp.pro
	echo QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} >> kmp.pro

	econf || die
	emake || die
}

src_install() {
	dobin kmp
	dodoc LICENSE README

	insinto /usr/share/pixmaps
	newins pics/icon.png kmp.png
	make_desktop_entry kmp "KMP" kmp.png "KDE;Qt;AudioVideo" "" "Multimedia"

	# KDE doesn't like two of the same .desktop entries
	rm -rf ${D}/usr/share/applnk
}
