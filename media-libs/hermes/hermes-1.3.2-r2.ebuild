# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/hermes/hermes-1.3.2-r2.ebuild,v 1.3 2002/07/22 14:37:06 seemant Exp $

MY_P=${P/h/H}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Library for fast colorspace conversion and other graphics routines"
SRC_URI="http://dark.x.dtu.dk/~mbn/clanlib/download/download-sphair/${MY_P}.tar.gz"
HOMEPAGE="http://hermes.terminal.at"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

DEPEND="sys-devel/libtool
	sys-devel/automake 
	sys-devel/autoconf" 

src_compile() {

	aclocal || die
	automake -a
	autoconf || die

	./configure \
		--prefix=/usr || die

	sh ltconfig ltmain.sh || die
	emake || die

}

src_install () {

	make \
		prefix=${D}/usr \
		install || die

	dodoc AUTHORS COPYING ChangeLog FAQ NEWS README TODO*

	dohtml docs/api/*.htm
	docinto print
	dodoc docs/api/*.ps
	docinto txt
	dodoc docs/api/*.txt
	docinto sgml
	dodoc docs/api/sgml/*.sgml
}
