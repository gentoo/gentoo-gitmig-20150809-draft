# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freetds/freetds-0.61-r1.ebuild,v 1.6 2004/03/14 13:18:24 mr_bones_ Exp $

DESCRIPTION="Tabular Datastream Library"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/${P}.tgz"
HOMEPAGE="http://www.freetds.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc ~mips hppa alpha amd64 ia64"

DEPEND="virtual/glibc"

src_compile() {
	econf --with-tdsver=7.0
	emake || die
}

src_install() {
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e 's/^DEFDIR = /DEFDIR = $(DESTDIR)/' \
		 ${S}/Makefile.orig > ${S}/Makefile
	make DESTDIR=${D} install || die
}
