# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/net-www/oops/oops-1.5.6.ebuild,v 1.1 2001/04/24 18:24:12 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="http://zipper.paco.net/~igor/oops/oops-1.5.6.tar.gz"
HOMEPAGE="http://zipper.paco.net/~igor/oops.eng/"
DESCRIPTION="An advanced multithreaded caching web proxy"

DEPEND="virtual/glibc
	dev-libs/libpcre
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {
#    local myconf
#    if [ "`use ssl` " ]
#    then
#        myconf="--enable-ssl"
#    else
#	myconf="--disable-ssl"
#    fi
    try ./configure --prefix=/usr --sysconfdir=/etc/oops --sbindir=/usr/sbin --with-regexp=pcre 
    try make

}


src_install() {

    try make DESTDIR=${D} install

    dodoc README SITES NEWS AUTHORS COPYING BUGS TODO

}
