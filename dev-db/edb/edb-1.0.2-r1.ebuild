# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.2-r1.ebuild,v 1.7 2002/07/23 02:44:48 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Enlightment Data Base"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"
HOMEPAGE="http://enlightenment.org"
LICENSE="EDB"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/glibc
	 =x11-libs/gtk+-1.2*"

DEPEND="$RDEPEND
	sys-apps/which"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --enable-compat185					\
		    --enable-dump185 					\
		    --enable-cxx
	assert

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
