# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.2.1-r2.ebuild,v 1.3 2002/08/01 16:50:26 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="A tool for exporting C libraries into Scheme"
SRC_URI="http://www.gnucash.org/pub/g-wrap/source/${P}.tar.gz"
HOMEPAGE="http://www.gnucash.org"

SLOT="1.2"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-util/guile-1.4
	>=dev-libs/slib-2.4.1"

src_compile() {

	# fix the "relink" bug in older versions of libtool
	elibtoolize

	econf \
		--libexecdir=/usr/lib/misc || die

	#GCC3 Compile fix, I tried to do this at the Makefile.in level
	#but it hates me with a passion so it goes here.
	for FILE in `find . -iname "Makefile"`
	do
		mv ${FILE} ${FILE}.old
		sed -e "s:-I/usr/include::" ${FILE}.old > ${FILE}
	done

	make || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS
}
