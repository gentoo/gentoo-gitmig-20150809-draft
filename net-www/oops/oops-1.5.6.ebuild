# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/oops/oops-1.5.6.ebuild,v 1.8 2002/07/14 20:25:23 aliz Exp $

S=${WORKDIR}/${P}
SRC_URI="http://zipper.paco.net/~igor/oops/oops-1.5.6.tar.gz"
HOMEPAGE="http://zipper.paco.net/~igor/oops.eng/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="An advanced multithreaded caching web proxy"

DEPEND="virtual/glibc sys-devel/gcc
        dev-libs/libpcre
        sys-devel/flex"

RDEPEND="virtual/glibc sys-devel/gcc"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e 's:/usr/local/lib/libpcre:/usr/lib/libpcre:g' configure.orig > configure
	cd ${S}/src/modules
}

src_compile() {
    try ./configure --prefix=/usr --libdir=/usr/lib/oops --enable-oops-user=squid \
    --sysconfdir=/etc/oops --sbindir=/usr/sbin --with-regexp=pcre --localstatedir=/var/run/oops
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
	local x
	local y
	local mylen
	local newf
	cd ${ROOT}/etc/oops
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
	if [ ! -e ${ROOT}/var/log/oops ]
	then
		install -d -o squid -g squid -m0770 ${ROOT}/var/log/oops
		chmod g+s ${ROOT}/var/log/oops
	fi
	if [ ! -e ${ROOT}/var/lib/oops/storage ]
	then
		install -d -o squid -g squid -m0770  ${ROOT}/var/lib/oops/storage
	fi
	if [ ! -e ${ROOT}/var/lib/oops/db ]
	then
		install -d -o squid -g squid -m0770 ${ROOT}/var/lib/oops/db
	fi
	if [ ! -e ${ROOT}/var/run/oops ]
	then
		install -d -o squid -g squid -m0775 ${ROOT}/var/run/oops
		chmod g+s ${ROOT}/var/run/oops
	fi
}

