# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.34-r1.ebuild,v 1.14 2004/02/01 10:54:01 kumba Exp $

IUSE="nls static build"

S="${WORKDIR}/${P}"
DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="mirror://gnu/bison/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	local myconf=

	use nls || myconf="--disable-nls"

	./configure --prefix=/usr \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	if [ -z "`use static`" ]
	then
		emake ${MAKEOPTS} || die
	else
		emake ${MAKEOPTS} LDFLAGS=-static || die
	fi
}

src_install() {

	make DESTDIR=${D} \
		datadir=/usr/share \
		mandir=/usr/share/man \
		infodir=/usr/share/info \
		install || die

	if [ -z "`use build`" ]
	then
		dodoc COPYING AUTHORS NEWS ChangeLog README REFERENCES OChangeLog
		docinto txt
		dodoc doc/FAQ
	else
		rm -rf ${D}/usr/share/man ${D}/usr/share/info
	fi
}

