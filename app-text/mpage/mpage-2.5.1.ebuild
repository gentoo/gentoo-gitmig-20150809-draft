# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="A printing tool"
SRC_URI="http://www.mesa.nl/pub/mpage/mpage251pre.tgz"
HOMEPAGE="http://www.mesa.nl/"
DEPEND="virtual/glibc"


src_compile() {
    emake CFLAGS="$CFLAGS \$(DEFS)" PREFIX=/usr MANDIR=/usr/share/man/man1 || die
}

src_install () {
    emake PREFIX=${D}/usr MANDIR=${D}/usr/share/man/man1 install || die
}

