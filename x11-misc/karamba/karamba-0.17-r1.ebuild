# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/karamba/karamba-0.17-r1.ebuild,v 1.4 2003/05/04 00:28:05 prez Exp $

inherit kde-base

need-kde 3

DESCRIPTION="A KDE program that displays a lot of various information right on your desktop."
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

newdepend ">=kde-base/kdelibs-3.1
	>=sys-apps/portage-2.0.26"

src_install () {
	einstall
	dodir /usr/share/doc/${P} /usr/share/karamba/themes /usr/share/karamba/bin
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}
	> ${D}/usr/share/karamba/themes/.keep
	> ${D}/usr/share/karamba/bin/.keep

	dodir /etc/env.d
	cp ${FILESDIR}/karamba-env ${D}/etc/env.d/99karamba
}
