# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.2.1-r1.ebuild,v 1.2 2002/07/11 06:30:20 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A tool for exporting C libraries into Scheme"
SRC_URI="http://www.gnucash.org/pub/g-wrap/source/${P}.tar.gz"
HOMEPAGE="http://"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-util/guile-1.4
	>=dev-libs/slib-2.4.1"


src_compile() {

	# fix the "relink" bug in older versions of libtool
	libtoolize --copy --force

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --libexecdir=/usr/lib/misc \
		    --infodir=/usr/share/info || die

	make || die
}

src_install () {

	make DESTDIR=${D} install || die
}

