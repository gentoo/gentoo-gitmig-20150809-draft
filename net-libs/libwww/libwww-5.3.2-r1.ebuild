# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.3.2-r1.ebuild,v 1.2 2001/05/30 18:24:34 achim Exp $

A=w3c-${P}.tar.gz
S=${WORKDIR}/w3c-${P}
DESCRIPTION="A general-purpose client side WEB API"
SRC_URI="http://www.w3.org/Library/Distribution/${A}"
HOMEPAGE="http://www.w3.org/Library/"

DEPEND="virtual/glibc sys-devel/perl
        >=sys-libs/zlib-1.1.3
        mysql? ( >=dev-db/mysql-3.23.26 )
        ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="virtual/glibc
         >=sys-libs/zlib-1.1.3
         ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {

    local myconf

    if [ "`use mysql`" ]
    then
      myconf="--with-mysql"
    fi

    if [ "`use ssl`" ]
    then
      myconf="${myconf} --with-ssl"
    fi

    try ./configure --prefix=/usr --host=${CHOST} --with-zlib \
	--with-md5 --with-expat ${myconf}
    try make

}

src_install () {

    try make prefix=${D}/usr install
    dodoc COPYRIGH ChangeLog 
    docinto html
    dodoc *.html

}

