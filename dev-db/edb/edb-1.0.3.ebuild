# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/edb/edb-1.0.3.ebuild,v 1.2 2002/06/18 21:22:31 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Enlightment Data Base"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"
HOMEPAGE="http://enlightenment.org"
SLOT="0"
LICENSE="as-is"

RDEPEND="virtual/glibc
	 =x11-libs/gtk+-1.2*"

DEPEND="$RDEPEND
	sys-apps/which"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/autogen.sh ${S}
}

src_compile() {
	./autogen.sh --host=${CHOST} \
		     --prefix=/usr \
		     --enable-compat185 \
		     --enable-dump185 \
		     --enable-cxx
	assert

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING README
}
