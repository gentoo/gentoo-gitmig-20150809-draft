# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ld.so/ld.so-1.9.11-r1.ebuild,v 1.1 2000/08/29 20:26:41 achim Exp $

P=ld.so-1.9.11
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux dynamic loader & linker"
CATEGORY="sys-devel"
SRC_URI="ftp://ftp.ods.com/pub/linux/${A}"

src_compile() {                           
	cd ${S}
}

src_install() {                               
	cd ${S}
	export PREFIX=${D}
	./instldso.sh --force
	prepman
	dodoc COPYRIGHT README ld-so/example/README*
}



