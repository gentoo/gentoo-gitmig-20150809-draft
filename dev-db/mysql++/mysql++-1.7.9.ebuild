# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Ric Messier <kilroy@WasHere.COM>
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql++/mysql++-1.7.9.ebuild,v 1.8 2003/06/12 20:29:17 msterret Exp $

S=${WORKDIR}/${P}

DESCRIPTION="C++ API interface to the MySQL database"

SRC_URI="http://mysql.he.net/Downloads/${PN}/${P}.tar.gz
	http://mysql.adgrafix.com/Downloads/${PN}/${P}.tar.gz
	http://mysql.fastmirror.com/Downloads/${PN}/${P}.tar.gz
	http://mysql.oms-net.nl/Downloads/${PN}/${P}.tar.gz
	mirror://gentoo/mysql++-gcc-3.0.patch.gz"

# This is the download page but includes links to other places
HOMEPAGE="http://www.mysql.org/downloads/api-mysql++.html"

IUSE=""
SLOT="0"
KEYWORDS="~x86"
LICENSE="LGPL-2"

# Depends on MySQL being installed, duh! :-)
DEPEND="<dev-db/mysql-4.0.0
		>=dev-db/mysql-3.23.49"

src_compile() {
 if [[ "${COMPILER}" == "gcc3" ]];then
	patch -p1 < ${DISTDIR}/mysql++-gcc-3.0.patch || die
	patch -p1 < ${FILESDIR}/mysql++-gcc-3.2.patch || die
 fi
	patch -p1 < ${FILESDIR}/mysql++-1.7.9_example.patch || die

	# not including the directives to where MySQL is because it seems to find it
	# just fine without

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--enable-exceptions \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die "unable to make"
}

src_install () {

	make DESTDIR=${D} install || die
	# install the docs and HTML pages
	dodoc doc/*
	dohtml doc/man-html/*

}
