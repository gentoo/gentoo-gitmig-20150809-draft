# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/skstream/skstream-0.2.2.ebuild,v 1.1 2002/04/07 23:00:22 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="ftp://victor.worldforge.org/pub/worldforge/libs/skstream/${P}.tar.gz"
HOMEPAGE="http://www.worldforge.org"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {

        ./configure --host=${CHOST} --prefix=/usr || die
        emake || die

}

src_install() {

        make DESTDIR=${D} install || die

}
