# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/aide/aide-0.8.ebuild,v 1.1 2002/03/15 11:32:29 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a free replacement for Tripwire"
SRC_URI="http://www.cs.tut.fi/~rammer/${P}.tar.gz"
HOMEPAGE="http://www.cs.tut.fi/~rammer/aide.html"

DEPEND="sys-apps/gzip 
	sys-devel/bison 
	sys-devel/flex
	dev-libs/libgcrypt
	app-crypt/mhash
	postgres? ( dev-db/postgresql )"

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
	
	
#	sed 's:\(^CRYPTLIB\).*:\1 = -lmhash -I/usr/lib/libgcrypt:' ${blah}.orig \
#		> ${blah}
	emake || die
}

src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man  install || die

	dodir /etc/aide
	cp doc/aide.conf ${D}/etc/aide

	dodoc AUTHORS COPYING INSTALL NEWS README 
	dohtml doc/manual.html

}

