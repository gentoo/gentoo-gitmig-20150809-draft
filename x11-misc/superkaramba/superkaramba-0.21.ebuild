# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superkaramba/superkaramba-0.21.ebuild,v 1.1 2003/05/03 23:39:17 prez Exp $

inherit kde-base

need-kde 3

IUSE="xmms"
DESCRIPTION="A KDE program that displays a lot of various information right on your desktop."
HOMEPAGE="http://netdragon.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdragon/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

newdepend ">=kde-base/kdelibs-3.1
	>=sys-apps/portage-2.0.26"

src_install () {
	einstall
	dodir /usr/share/doc/${P}
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}
}
