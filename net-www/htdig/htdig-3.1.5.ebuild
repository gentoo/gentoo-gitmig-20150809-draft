# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/htdig/htdig-3.1.5.ebuild,v 1.4 2000/11/05 12:59:09 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="WWW index and searching system"
SRC_URI="http://www.htdig.org/files/${A}"
HOMEPAGE="http://www.htdig.org"

DEPEND=">=sys-apps/bash-2.04
	>=sys-devel/gcc-2.95.2
	>=sys-libs/glibc-2.1.3
	>=sys-libs/zlib-1.1.3"

src_unpack() {
  unpack ${A}
  cp ${FILESDIR}/CONFIG.in ${S}
}

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
	--with-cgi-bin-dir=/usr/local/httpd/cgi-bin \
	--with-image-dir=/usr/local/httpd/images/htdig \
	--with-search-dir=/usr/local/httpd/htdocs/htdig
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} CGIBIN_DIR=${D}/usr/local/httpd/cgi-bin \
	SEARCH_DIR=${D}/usr/local/httpd/htdocs/htdig \
	IMAGE_DIR=${D}/usr/local/httpd/htdocs/images/htdig \
	exec_prefix=${D}/usr install
    dosed /etc/httpd/htdig.conf /usr/bin/rundig
    dodoc ChangeLog COPYING README

}

