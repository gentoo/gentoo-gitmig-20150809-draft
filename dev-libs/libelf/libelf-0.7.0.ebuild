# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libelf/libelf-0.7.0.ebuild,v 1.1 2001/08/19 21:11:57 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ELF object file access library"
SRC_URI="http://www.stud.uni-hannover.de/~michael/software/libelf-0.7.0.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/~michael/software/"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"

src_compile() {
    if [ -z "`use nls`" ] ; then
	myconf="--disable-nls"
    fi
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} ${myconf} --enable-shared
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    dodoc COYPING.LIB CHangeLog VERSION README
}

