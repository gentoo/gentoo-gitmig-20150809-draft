# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ld.so/ld.so-1.9.11-r1.ebuild,v 1.3 2000/11/30 23:15:06 achim Exp $

P=ld.so-1.9.11
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux dynamic loader & linker"
CATEGORY="sys-devel"
SRC_URI="ftp://ftp.ods.com/pub/linux/${A}"
DEPEND=""
RDEPEND="=sys-libs/lib-compat"

src_compile() {                           
	cd ${S}
}

src_install() {                               
	cd ${S}
	export PREFIX=${D}
	./instldso.sh --force
	preplib /
	dodoc COPYRIGHT README ld-so/example/README*
}



