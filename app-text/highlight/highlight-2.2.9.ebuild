# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/highlight/highlight-2.2.9.ebuild,v 1.1 2005/03/26 02:40:12 pclouds Exp $


DESCRIPTION="converts source code to formatted text ((X)HTML, RTF, (La)TeX, XSL-FO, XML) with syntax highlighting."
HOMEPAGE="http://www.andre-simon.de/"
SRC_URI="http://www.andre-simon.de/zip/highlight-2.2-9.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${PN}-2.2-9


src_compile() {
	make -f makefile || die
}

src_install() {
	DESTDIR=${D} bin_dir=${D}/usr/bin make -f makefile -e install || die
}

