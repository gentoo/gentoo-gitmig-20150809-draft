# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ld.so/ld.so-1.9.11-r2.ebuild,v 1.9 2002/09/21 03:51:12 vapier Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux dynamic loader & linker"
SRC_URI="ftp://ftp.ods.com/pub/linux/${A}"
HOMEPAGE="http://freshmeat.net/projects/ld.so/"
RDEPEND="sys-libs/lib-compat"
LICENSE="LD.SO"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp instldso.sh instldso.orig
	sed -e "s:usr/man:usr/share/man:g" \
	    instldso.orig > instldso.sh

}

src_install() {

	PREFIX=${D} ./instldso.sh --force

   # Remove stuff that comes with glibc
   rm -rf ${D}/sbin ${D}/usr/bin
   rm ${D}/usr/share/man/man8/ldconfig*

	preplib /

	dodoc COPYRIGHT README ld-so/example/README*

}
