# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superkaramba/superkaramba-0.35.ebuild,v 1.1 2004/11/25 10:02:19 motaboy Exp $

inherit kde eutils

DESCRIPTION="A version of Karamba with extra extensions in-built"
HOMEPAGE="http://netdragon.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdragon/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc"

DEPEND="dev-lang/python"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	useq arts || epatch ${FILESDIR}/${P}-configure-arts.patch
}

src_install() {
	kde_src_install
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
