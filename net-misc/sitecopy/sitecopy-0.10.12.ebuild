# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.10.12.ebuild,v 1.5 2001/06/09 00:48:47 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/sitecopy/${P}.tar.gz"
HOMEPAGE="http://www.lyr.org/sitecopy/"
DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	>=gnome-base/libxml-1.8.10
        ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {

    local myconf
    if [ "`use ssl`" ] ; then
      myconf="--with-ssl=/usr"
    else
      myconf="--without-ssl"
    fi
    try ./configure --prefix=/usr --enable-libxml --host=${CHOST} $myconf
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install

}

