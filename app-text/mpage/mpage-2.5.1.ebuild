# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mpage/mpage-2.5.1.ebuild,v 1.12 2004/03/12 08:26:06 mr_bones_ Exp $

DESCRIPTION="A printing tool"
HOMEPAGE="http://www.mesa.nl/"
SRC_URI="http://www.mesa.nl/pub/mpage/mpage251pre.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="$CFLAGS \$(DEFS)" PREFIX=/usr MANDIR=/usr/share/man/man1 || die
}

src_install () {
	make PREFIX=${D}/usr MANDIR=${D}/usr/share/man/man1 install || die
}
