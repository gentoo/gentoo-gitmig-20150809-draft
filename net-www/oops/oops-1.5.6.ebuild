# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/net-www/oops/oops-1.5.6.ebuild,v 1.3 2001/04/25 00:15:35 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="http://zipper.paco.net/~igor/oops/oops-1.5.6.tar.gz"
HOMEPAGE="http://zipper.paco.net/~igor/oops.eng/"
DESCRIPTION="An advanced multithreaded caching web proxy"

DEPEND="virtual/glibc >=sys-libs/db-3.2.3h dev-libs/libpcre ssl? ( >=dev-libs/openssl-0.9.6 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e 's:/usr/local/lib/libpcre:/usr/lib/libpcre:g' configure.orig > configure
	cd ${S}/src/modules
}

src_compile() {
    try ./configure --prefix=/usr --libdir=/usr/lib/oops --enable-oops-user=squid --sysconfdir=/etc/oops --sbindir=/usr/sbin --with-regexp=pcre --localstatedir=/var/run/oops
	cd src
	cp config.h.in config.h.in.orig
	sed -e '/STRERROR_R/d' config.h.in.orig > config.h.in
	cp Makefile Makefile.orig
	sed -e 's:${OOPS:${DESTDIR}/${OOPS:g' Makefile.orig > Makefile
	cd ..
	try make
}

src_install() {
    dodir /usr/sbin
	chown squid.squid ${D}
	try make DESTDIR=${D} install
	chmod -R g+srw ${D}/etc/oops
	chmod -R g+rw ${D}/etc/oops/*	
	dodir /var/log/oops
	
	chmod o-rwx ${D}/var/log/oops
	
	dodir /var/lib/oops/storage
	dodir /var/lib/oops/db
	chmod o-rwx ${D}/var/lib/oops
	
	dodir /var/run/oops
	chmod o-rwx ${D}/var/run/oops
	chown -R squid.squid ${D}/var/run/oops
	
	insinto /etc/oops
	doins ${FILESDIR}/oops.cfg
	cd ${D}
	
	#cleanups
	rm -rf ${D}/usr/oops
	rm -rf ${D}/usr/lib/oops/modules

	#config files

	cd ${D}/etc/oops
	local x
	local y
	for y in . tables
	do
		for x in ${y}/*
		do
			if [ -f $x ]
			then
				mv $x $x.eg	
			fi
		done
	done
}

pkg_postinst() {
	cd ${ROOT}/etc/oops
	local x
	local y
	local mylen
	local newf
	for y in . tables
	do
		for x in ${y}/*.eg
		do
			realf=`echo $x | sed -e 's/.eg$//'`
			if [ ! -e ${realf} ]
			then
				cp ${x} ${realf}
			fi
		done
	done
}

