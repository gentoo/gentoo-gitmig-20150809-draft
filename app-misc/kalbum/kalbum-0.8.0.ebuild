# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit kde-base

IUSE=""
DESCRIPTION="A photo album generator for KDE 3.x"
SRC_URI="http://www.paldandy.com/kalbum/data/${P}/${P}.tar.bz2"
HOMEPAGE="http://www.paldandy.com/kalbum/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

need-kde 3


src_install() {

	kde_src_install
	
	insopts -o root -g root -m 644
	insinto /usr/share/mimelnk/application/
	doins ${FILESDIR}/${P}/x-kalbum.desktop

}
