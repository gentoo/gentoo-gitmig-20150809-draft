# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/star/star-1.3_alpha8.ebuild,v 1.2 2001/01/31 20:49:07 achim Exp $

A=star-1.3a8.tar.gz
S=${WORKDIR}/star-1.3

DESCRIPTION="Includes star, an enhanced (world\'s fastest) tar, as well as enhanced mt/rmt"
SRC_URI="ftp://ftp.fokus.gmd.de/pub/unix/star/alpha/${A}"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/star.html"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/DEFAULTS
	cp Defaults.linux Defaults.linux.orig
	sed -e 's:/opt/schily:/usr:g' -e 's:bin:root:g' Defaults.linux.orig > Defaults.linux
}

src_compile() {                           
	cd ${S}
	try ./Gmake.linux
}

src_install() {                               
	cd ${S}
	try make install INS_BASE=${D}/usr
	insinto /etc/default
	newins ${S}/rmt/rmt.dfl rmt
	dodoc BUILD COPYING Changelog AN-1.* README README.* PORTING TODO
	rm ${D}/usr/man/man1/match*
	cd ${S}/usr/bin
	rm smt ustar
	ln -s star ustar
	ln -s mt smt
}


