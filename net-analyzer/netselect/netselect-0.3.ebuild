# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netselect/netselect-0.3.ebuild,v 1.1 2002/07/11 16:32:05 stroke Exp $

DESCRIPTION="Ultrafast implementation of ping."
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/netselect/"
SRC_URI="http://www.worldvisions.ca/~apenwarr/netselect/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

newdepend /c

S=${WORKDIR}/${PN}

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
