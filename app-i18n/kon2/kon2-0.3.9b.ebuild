# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kon2/kon2-0.3.9b.ebuild,v 1.1 2002/08/12 15:07:52 stubear Exp $

DESCRIPTION="KON Kanji ON Linux console"
SRC_URI="http://www.rarf.riken.go.jp/archives/Linux/kondara/Kondara-2.0/errata/SOURCES/kon2-0.3.9b.tar.gz"
HOMEPAGE=""
LICENSE="as-is"
SLOT=0
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND=">=konfont-0.1"

S=${WORKDIR}/${P}


src_unpack(){
	unpack ${P}.tar.gz
	cd ${S}
	zcat ${FILESDIR}/kon2-0.3.9b-gentoo.patch.gz | patch -p1
}

src_compile(){
	make config || die;
	make depend || die;
	make || die;
}

src_install(){
	make LIBDIR=${D}/etc MANDIR=${D}/usr/man/man1 BINDIR=${D}/usr/bin install || die;

	if [ ! -e /usr/share/terminfo/k/kon ];
	then
		dodir /usr/share/terminfo
		cd ${S}
		tic terminfo.kon -o${D}/usr/share/terminfo
	fi
}

