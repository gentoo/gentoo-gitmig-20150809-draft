# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xsim/xsim-0.3.9.4.ebuild,v 1.3 2003/06/29 22:12:04 aliz Exp $

KEYWORDS="x86"
DESCRIPTION="A simple and fast GBK Chinese XIM server."
HOMEPAGE="http://developer.berlios.de/projects/xsim/"
SRC_URI="http://download.berlios.de/xsim/${P}.tar.gz"

LICENSE="LGPL-2.1"

DEPEND="virtual/glibc
	>=sys-libs/db-3.0.0"
IUSE=""

SLOT="0"

src_compile() {

	cd ${S}
	for file in `find . -iname Makefile.in`
	do
		sed -e "s/xsim_\(.*\)@prefix@/xsim_\1\$(DESTDIR)\/@prefix@/g" ${file} >Makefile.in.tmp
		mv Makefile.in.tmp ${file}
	done

	./configure \
	--prefix=/usr/lib/xsim \
	--mandir=/usr/share/man \
	|| die

	for file in `find . -iname Makefile`
	do
		echo CFLAGS=${CFLAGS} > Makefile.tmp
		echo CXXFLAGS=${CXXFLAGS} -Wno-deprecated >> Makefile.tmp
		sed -e "s/CFLAGS          =/CFLAGS+=/"  -e "s/CXXFLAGS\t/CXXFLAGS+/" ${file} >> Makefile.tmp
		mv Makefile.tmp ${file}
	done

	make || die
}

src_install () {
	make DESTDIR=${D} \
	install || die
	make DESTDIR=${D} \
	install-data || die
	dodir /usr/bin
	dosym /usr/lib/xsim/bin/xsim /usr/bin/xsim
	# install docs
	dodoc ChangeLog COPYING INSTALL README* TODO
}

