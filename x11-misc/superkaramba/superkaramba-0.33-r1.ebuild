# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superkaramba/superkaramba-0.33-r1.ebuild,v 1.11 2005/03/25 15:37:33 kugelfang Exp $

inherit kde eutils

DESCRIPTION="A version of Karamba with extra extensions in-built"
HOMEPAGE="http://netdragon.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdragon/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~amd64"
IUSE="doc"

need-kde 3

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/dock-fix.patch
	epatch ${FILESDIR}/gcc-3.4.patch
}

src_install () {
	einstall
	dodir /usr/share/karamba/themes /usr/share/karamba/bin
	keepdir /usr/share/karamba/themes /usr/share/karamba/bin
	dodir /etc/env.d
	cp ${FILESDIR}/karamba-env ${D}/etc/env.d/99karamba
	if use doc; then
		dodir /usr/share/doc/${P}/examples
		mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}
		cp ${S}/examples/* ${D}/usr/share/doc/${P}/examples
	else
		rm -Rf ${D}/usr/share/doc
	fi
}
