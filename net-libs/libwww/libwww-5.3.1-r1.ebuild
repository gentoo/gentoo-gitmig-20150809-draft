# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.3.1-r1.ebuild,v 1.2 2000/12/21 08:22:29 achim Exp $

A=w3c-${P}.tar.gz
S=${WORKDIR}/w3c-${P}
DESCRIPTION="A general-purpose client side WEB API"
SRC_URI="http://www.w3.org/Library/Distribution/${A}"
HOMEPAGE="http://www.w3.org/Library/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=dev-db/mysql-3.23.26
	>=dev-libs/openssl-0.9.6"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --with-zlib \
	--with-md5 --with-ssl --with-mysql
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    dodoc COPYRIGHT 
    docinto html
    dodoc *.html

}

