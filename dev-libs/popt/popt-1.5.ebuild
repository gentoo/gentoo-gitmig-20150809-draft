# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.5.ebuild,v 1.7 2002/08/01 11:59:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Parse Options: command line parser"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-3.0.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    $myconf || die

	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING README
}
