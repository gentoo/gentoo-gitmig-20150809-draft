# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/highlight/highlight-2.4.3.ebuild,v 1.3 2006/03/09 12:17:54 ehmsen Exp $

DESCRIPTION="converts source code to formatted text ((X)HTML, RTF, (La)TeX, XSL-FO, XML) with syntax highlighting."
HOMEPAGE="http://www.andre-simon.de/"
SRC_URI="http://www.andre-simon.de/zip/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	make -f makefile || die
}

src_install() {
	DESTDIR=${D} bin_dir=${D}/usr/bin make -f makefile -e install || die
}
