# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.80.ebuild,v 1.20 2004/07/15 03:34:45 agriffis Exp $

inherit gnuconfig

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="http://www.gnu.org/software/make/make.html"
SRC_URI="ftp://ftp.gnu.org/gnu/make/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="nls static build uclibc"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/libc"

src_compile() {
	# Detect mips and uclibc systems properly
	gnuconfig_update

	local myconf=""
	use nls || myconf="--disable-nls"

	./configure \
		--prefix=/usr \
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

		fperms 0755 /usr/bin/make
		dosym make /usr/bin/gmake

		dodoc AUTHORS ChangeLog NEWS README*
	else
		dobin make || die
	fi
}
