# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/freetds/freetds-0.53-r1.ebuild,v 1.1 2002/08/30 14:45:30 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tabular Datastream Library"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/${P}.tgz"
HOMEPAGE="http://ibiblio.org/pub/Linux/ALPHA/freetds/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {

	unpack ${P}.tgz
	cd ${S}

}

src_compile() {

	econf \
		--with-tdsver=7.0 \
		|| die "./configure failed"

	emake || die

	 mv ${S}/Makefile ${S}/Makefile.orig
	 sed -e 's/^DEFDIR = /DEFDIR = $(DESTDIR)/' \
		 -e 's/^ETC = /ETC = $(DESTDIR)/' \
		 ${S}/Makefile.orig > ${S}/Makefile
}

src_install () {
	make DESTDIR=${D} install || die
}
