# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kalbum/kalbum-0.8.0.ebuild,v 1.4 2007/02/05 10:44:39 flameeyes Exp $

inherit kde

IUSE=""
DESCRIPTION="A photo album generator for KDE 3.x"
SRC_URI="http://www.paldandy.com/kalbum/data/${P}/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"
HOMEPAGE="http://www.paldandy.com/kalbum/"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"

need-kde 3

src_install() {
	kde_src_install

	insopts -o root -g root -m 644
	insinto /usr/share/mimelnk/application/
	doins ${FILESDIR}/${P}/x-kalbum.desktop
}
