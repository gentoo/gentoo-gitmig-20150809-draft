# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql++/mysql++-1.7.9.ebuild,v 1.10 2003/09/06 22:25:50 msterret Exp $

inherit gcc eutils

DESCRIPTION="C++ API interface to the MySQL database"
# This is the download page but includes links to other places
HOMEPAGE="http://www.mysql.org/downloads/api-mysql++.html"
SRC_URI="http://mysql.he.net/Downloads/${PN}/${P}.tar.gz
	http://mysql.adgrafix.com/Downloads/${PN}/${P}.tar.gz
	http://mysql.fastmirror.com/Downloads/${PN}/${P}.tar.gz
	http://mysql.oms-net.nl/Downloads/${PN}/${P}.tar.gz
	mirror://gentoo/mysql++-gcc-3.0.patch.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"

# Depends on MySQL being installed, duh! :-)
DEPEND="<dev-db/mysql-4.0.0
	>=dev-db/mysql-3.23.49"

src_compile() {
	if [ `gcc-major-version` -eq 3 ] ; then
		epatch ${DISTDIR}/mysql++-gcc-3.0.patch
		epatch ${FILESDIR}/mysql++-gcc-3.2.patch
	fi
	epatch ${FILESDIR}/mysql++-1.7.9_example.patch

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

src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/*
	dohtml doc/man-html/*
}
