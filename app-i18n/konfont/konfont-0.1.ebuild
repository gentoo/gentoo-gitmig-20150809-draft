# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/konfont/konfont-0.1.ebuild,v 1.4 2003/09/21 10:17:41 aliz Exp $

DESCRIPTION="Fontset for KON2"
SRC_URI="mirror://debian/dists/potato/main/source/utils/${P/-/_}.orig.tar.gz"
HOMEPAGE=""
LICENSE="as-is"
SLOT=0
KEYWORDS="x86"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_unpack(){
	unpack konfont_0.1.orig.tar.gz
}

src_install(){
	dodir /usr/share/fonts

	cd ${S}.orig/fonts
	install -c -m0444 pubfont.a.gz ${D}/usr/share/fonts
	install -c -m0444 pubfont.k.gz ${D}/usr/share/fonts
}

