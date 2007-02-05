# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/karamba/karamba-0.17-r2.ebuild,v 1.5 2007/02/05 10:26:34 flameeyes Exp $

inherit kde eutils

DESCRIPTION="A KDE program that displays a lot of various information right on your desktop."
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/src/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE=""

need-kde 3.1

src_install () {
	kde_src_install

	dodir /usr/share/doc/${P} /usr/share/karamba/themes /usr/share/karamba/bin
	mv "${D}"/usr/share/doc/* "${D}/usr/share/doc/${P}"
	keepdir /usr/share/karamba/themes/.keep
	keepdir /usr/share/karamba/bin/.keep

	newenvd "${FILESDIR}/karamba-env" 99karamba
}
