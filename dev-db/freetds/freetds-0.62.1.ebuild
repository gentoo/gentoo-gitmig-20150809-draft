# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freetds/freetds-0.62.1.ebuild,v 1.7 2005/01/01 17:32:41 eradicator Exp $

DESCRIPTION="Tabular Datastream Library"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/${P}.tar.gz"
HOMEPAGE="http://www.freetds.org/"
IUSE="odbc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~mips ~hppa ~alpha amd64 ia64"
DEPEND="virtual/libc"

src_compile() {
	local myconf
	use odbc && myconf="--with-unixodbc=/usr"
	econf --with-tdsver=7.0 ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e 's/^DEFDIR = /DEFDIR = $(DESTDIR)/' \
		${S}/Makefile.orig > ${S}/Makefile
	make DESTDIR=${D} install || die
}
