# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-4.2.3.ebuild,v 1.2 2002/12/26 20:29:16 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTML documentation for PHP"
SRC_URI="mirror://gentoo/php_manual_en-4.2.3.tar.bz2"
HOMEPAGE="http://www.php.net/download-docs.php"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

src_unpack() {
    mkdir ${S}
    cd ${S}
    unpack ${A}
}

src_install() {
    docinto html
    # to prevent files from being gzipped they are copied with cp
    # instead of dodoc
	cd ${S}
    cp * ${D}/usr/share/doc/${P}/html
}
