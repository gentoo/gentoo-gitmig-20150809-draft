# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libelf/libelf-0.7.0.ebuild,v 1.2 2002/03/24 21:42:19 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ELF object file access library"
SRC_URI="http://www.stud.uni-hannover.de/~michael/software/libelf-0.7.0.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/~michael/software/"

DEPEND="virtual/glibc nls?
	( sys-devel/gettext )"

src_compile() {
    if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
    fi
	
    ./configure --prefix=/usr \
		--host=${CHOST} \
		--enable-shared \
		${myconf} || die
		
    emake || die
}

src_install () {
    make prefix=${D}/usr \
		install || die
		
    dodoc COYPING.LIB CHangeLog VERSION README
}

