# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/db/db-3.1.17.ebuild,v 1.1 2000/11/16 02:08:13 drobbins Exp $

A=${P}-patched.tar.gz
S=${WORKDIR}/${P}-patched
DESCRIPTION="Berkeley DB for transaction support in MySQL"
SRC_URI="ftp://mysql.valueclick.com/mysql/Downloads/db/${A}
	 http://download.sourceforge.net/pub/mirrors/mysql/Downloads/db/${A}"
HOMEPAGE="http://www.mysql.com"


src_compile() {

    cd ${S}/build_unix
    try ../dist/configure --enable-compat185 --prefix=/usr --host=${CHOST} --enable-shared --enable-rpc
    try make

}

src_install () {

    cd ${S}/build_unix
    try make prefix=${D}/usr install
    cd ${S}
    dodoc README LICENSE
	mv ${D}/usr/docs ${D}/usr/doc/${PF}/html
}

