# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mpage/mpage-2.5.1.ebuild,v 1.9 2003/06/12 20:27:43 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A printing tool"
SRC_URI="http://www.mesa.nl/pub/mpage/mpage251pre.tgz"
HOMEPAGE="http://www.mesa.nl/"
KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="freedist"
DEPEND="virtual/glibc"


src_compile() {
    emake CFLAGS="$CFLAGS \$(DEFS)" PREFIX=/usr MANDIR=/usr/share/man/man1 || die
}

src_install () {
    emake PREFIX=${D}/usr MANDIR=${D}/usr/share/man/man1 install || die
}

