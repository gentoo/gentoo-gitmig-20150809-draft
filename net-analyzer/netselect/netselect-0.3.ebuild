# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netselect/netselect-0.3.ebuild,v 1.14 2004/03/25 08:12:33 kumba Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Ultrafast implementation of ping."
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/netselect/"
SRC_URI="http://www.worldvisions.ca/~apenwarr/netselect/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha hppa mips amd64 ia64 ppc64"

src_compile() {
	mv Makefile Makefile.orig
	sed -e "s:PREFIX =.*:PREFIX = ${D}usr:" \
		-e "s:CFLAGS =.*:CFLAGS = -Wall -I. -g ${CFLAGS}:" \
		-e '23,27d' \
		-e '34d' \
		Makefile.orig > Makefile
	rm Makefile.orig

	make || die
}

src_install () {
	make install || die

	dodoc ChangeLog HISTORY README*
}
