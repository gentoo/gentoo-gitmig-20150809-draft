# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Michael M Nazaroff <naz@themoonsofjupiter.net>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtkhx/gtkhx-0.9.2.ebuild,v 1.2 2002/05/23 06:50:17 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a GTK+ Hotline Client based off of Hx"
SRC_URI="http://gtkhx.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://gtkhx.sourceforge.net/index.html"
SLOT="0"
DEPEND="virtual/glibc
         =x11-libs/gtk+-1.2*"

RDEPEND="$DEPEND"

src_compile() {

        ./configure \
                --host=${CHOST} \
                --prefix=/usr \
                --infodir=/usr/share/info \
                --mandir=/usr/share/man || die 
        emake || die
}

src_install () {

        make DESTDIR=${D} install || die
        dohtml doc/*.html
        dodoc   doc/AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}


