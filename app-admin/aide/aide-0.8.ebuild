# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/aide/aide-0.8.ebuild,v 1.5 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a free replacement for Tripwire"
SRC_URI="http://www.cs.tut.fi/~rammer/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cs.tut.fi/~rammer/aide.html"
LICENSE="GPL-2"

DEPEND="sys-apps/gzip 
	sys-devel/bison 
	sys-devel/flex
	dev-libs/libgcrypt
	app-crypt/mhash
	postgres? ( dev-db/postgresql )"

RDEPEND=""

src_compile() {

	local myconf
	use postgres && myconf="${myconf} --with-psql"
	use nls &&  myconf="${myconf} --with-locale"
	
	./configure	\
		--prefix=/usr	\
		--with-zlib	\
		--sysconfdir=/etc/aide	\
		--host=${CHOST}	\
		--with-mhash	\
		--with-extra-lib=/usr/lib	\
		${myconf} || die
	
	emake || die
}

src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man  install || die

	dodir /etc/aide
	cp doc/aide.conf ${D}/etc/aide

	dodoc AUTHORS COPYING INSTALL NEWS README 
	dohtml doc/manual.html

}
