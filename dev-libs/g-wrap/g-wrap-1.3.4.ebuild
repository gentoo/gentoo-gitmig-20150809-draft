# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.3.4.ebuild,v 1.6 2004/01/09 19:20:38 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A tool for exporting C libraries into Scheme"
SRC_URI="http://www.gnucash.org/pub/g-wrap/source/${P}.tar.gz"
HOMEPAGE="http://www.gnucash.org"

SLOT="1.3"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc alpha"

inherit flag-o-matic

filter-flags "-O?"

DEPEND=">=dev-util/guile-1.4
	>=dev-libs/slib-2.4.2"


src_compile() {

	econf \
		--libexecdir=/usr/lib/misc || die

#	#GCC3 Compile fix, I tried to do this at the Makefile.in level
#	#but it hates me with a passion so it goes here.
#	for FILE in `find . -iname "Makefile"`
#	do
#		mv ${FILE} ${FILE}.old
#		sed -e "s: -I/usr/include : :" ${FILE}.old > ${FILE}
#	done

	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS
}
