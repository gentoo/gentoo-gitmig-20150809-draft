# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.35.ebuild,v 1.23 2004/07/15 03:11:11 agriffis Exp $

IUSE="nls static build" # icc"

DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="mirror://gnu/bison/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa "

DEPEND="nls? ( sys-devel/gettext )"
#	icc? ( dev-lang/icc )"

src_compile() {

	local myconf=

	use nls || myconf="--disable-nls"
#	use icc && CC="iccbin" CXX="iccbin" LD="iccbin"

	./configure --prefix=/usr \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	if ! use static
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

	if ! use build
	then
		dodoc COPYING AUTHORS NEWS ChangeLog README REFERENCES OChangeLog
		docinto txt
		dodoc doc/FAQ
	else
		rm -rf ${D}/usr/share/man ${D}/usr/share/info
	fi
}
