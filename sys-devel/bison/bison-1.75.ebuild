# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.75.ebuild,v 1.1 2002/10/20 09:05:26 azarah Exp $

IUSE="nls static build"

S="${WORKDIR}/${P}"
DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/bison/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	local myconf=""
	
	use nls || myconf="--disable-nls"

	econf ${myconf} || die

	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS="-static" || die
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

