# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/net-www/oops/oops-1.5.6.ebuild,v 1.2 2001/04/24 19:30:54 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="http://zipper.paco.net/~igor/oops/oops-1.5.6.tar.gz"
HOMEPAGE="http://zipper.paco.net/~igor/oops.eng/"
DESCRIPTION="An advanced multithreaded caching web proxy"

DEPEND="virtual/glibc dev-libs/db
	dev-libs/libpcre
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e 's:/usr/local/lib/libpcre:/usr/lib/libpcre:g' configure.orig > configure
	cd ${S}/src/modules
}

src_compile() {
    try ./configure --prefix=/usr --libdir=/usr/lib/oops --enable-oops-user=squid --sysconfdir=/etc/oops --sbindir=/usr/sbin --with-regexp=pcre --localstatedir=/var/run
	cd src
	cp config.h.in config.h.in.orig
	sed -e '/STRERROR_R/d' config.h.in.orig > config.h.in
	cp Makefile Makefile.orig
	sed -e 's:${OOPS:${DESTDIR}/${OOPS:g' Makefile.orig > Makefile
	cd ..
	try make

}

src_install() {
    try make DESTDIR=${D} install
	dodir /var/log/oops
	dodir /var/lib/oops/storage
	dodir /var/lib/oops/db
	insinto /etc/oops
	doins ${FILESDIR}/oops.cfg
}
