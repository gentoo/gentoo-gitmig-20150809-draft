# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.1.17-r2.ebuild,v 1.2 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Powertweak"
SRC_URI="http://powertweak.sourceforge.net/files/${P}.tar.bz2"
SLOT="0"
HOMEPAGE="http://powertweak.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-libs/libxml-1.8.10"

src_unpack() {

	CFLAGS="${CPPFLAGS} -Wno-error"
	CPPFLAGS="${CPPFLAGS} -Wno-deprecated"
	unpack ${A}
	cd ${S}
	for FILE in `find . -iname "Makefile*"`;do
		sed -e "s:\(^CFLAGS =.*\):\1 ${CFLAGS}:" \
		    -e "s:\(^CPPFLAGS =.*\):\1 ${CPPFLAGS}:" \
			${FILE} > ${FILE}.hacked || die "Hack failed"
		mv ${FILE}.hacked ${FILE}
	done
}	

src_compile() {

	CFLAGS="${CPPFLAGS} -Wno-error"
	CPPFLAGS="${CPPFLAGS} -Wno-deprecated"
	cp /usr/share/libtool/ltmain.sh .
	./configure --host=${CHOST} --prefix=/usr || die "Configure failed"
	emake || die "Make failed"
}

src_install() {

	make install prefix=${D}/usr || die "Install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	docinto Documentation
	dodoc Documentation/* 
}

