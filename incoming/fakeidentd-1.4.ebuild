										      # Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Woodchip
# $Header: /var/cvsroot/gentoo-x86/incoming/fakeidentd-1.4.ebuild,v 1.1 2001/08/22 11:44:52 danarmak Exp $

DESCRIPTION="A static, secure identd. Ideal for a NAT box."
HOMEPAGE="http://www.ajk.tele.fi/~too/sw"

S=${WORKDIR}/${P}
SRC_URI="http://www.ajk.tele.fi/~too/sw/releases/identd.c
                 http://www.ajk.tele.fi/~too/sw/identd.readme"

DEPEND="virtual/glibc"

src_unpack() {
        mkdir ${P}
        cp ${DISTDIR}/identd.c ${DISTDIR}/identd.readme ${P}
}

src_compile() {
        cd ${S}
        try gcc identd.c -o fakeidentd ${CFLAGS}
}

src_install () {
        dosbin fakeidentd
        dodoc identd.readme
        # The changelog in the source is more current. Its only ~13kB anyway.
        dodoc identd.c
}
