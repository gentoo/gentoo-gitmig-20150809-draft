# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.79.1-r4.ebuild,v 1.14 2004/07/15 03:34:45 agriffis Exp $

IUSE="nls static build"

DESCRIPTION="Standard tool to compile source trees"
SRC_URI="ftp://prep.ai.mit.edu/gnu/make/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/make/make.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips"

DEPEND="virtual/libc nls? ( sys-devel/gettext )"
RDEPEND="virtual/libc"

src_compile() {
	local myconf=""
	if ! use nls
	then
		myconf="--disable-nls"
	fi

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--info=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	if ! use static
	then
		make ${MAKEOPTS} || die
	else
		make ${MAKEOPTS} LDFLAGS=-static || die
	fi
}

src_install() {
	if ! use build
	then
		make DESTDIR=${D} install || die

		chmod 0755 ${D}/usr/bin/make

		dodoc AUTHORS COPYING ChangeLog NEWS README*
	else
		dobin make
	fi
}
