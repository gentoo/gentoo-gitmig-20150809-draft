# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-3.3.6-r1.ebuild,v 1.4 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="System performance tools for Linux"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/status/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
LICENSES="GPL-2"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"
		
RDEPEND="virtual/glibc"

src_unpack() {
    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	yes "" | make config
	cp build/CONFIG build/CONFIG.orig
	use nls || sed 's/\(ENABLE_NLS\ =\ \)y/\1n/g' build/CONFIG.orig > build/CONFIG
    make PREFIX=/usr || die

}

src_install () {

    dodir /usr/bin
    dodir /usr/share/man/man{1,8}
    dodir /var/log/sa
    try make DESTDIR=${D} PREFIX=/usr MAN_DIR=/usr/share/man DOC_DIR=/usr/share/doc/${PF} install

}

