# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.2.1.ebuild,v 1.1 2002/03/16 21:15:02 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A tool for exporting C libraries into Scheme"
SRC_URI="ftp://ftp.gnucash.org/pub/g-wrap/source/${P}.tar.gz"
HOMEPAGE="http://"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-util/guile-1.4
	>=dev-libs/slib-2.4.1"


src_compile() {

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --libexecdir=/usr/lib/misc \
		    --infodir=/usr/share/info || die

	make || die
}

src_install () {

	make DESTDIR=${D} install || die
}

