# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.80.ebuild,v 1.15 2004/03/22 03:20:08 kumba Exp $

inherit gnuconfig

IUSE="nls static build"

S=${WORKDIR}/${P}
DESCRIPTION="Standard tool to compile source trees"
SRC_URI="ftp://ftp.gnu.org/gnu/make/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/make/make.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ppc sparc alpha hppa mips ia64 ppc64 s390"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_compile() {

	# Detect mips systems properly
	use mips && gnuconfig_update

	local myconf=""
	use nls || myconf="--disable-nls"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--info=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	if [ -z "`use static`" ]
	then
		make ${MAKEOPTS} || die
	else
		make ${MAKEOPTS} LDFLAGS=-static || die
	fi
}

src_install() {
	if [ -z "`use build`" ]
	then
		make DESTDIR=${D} install || die

		fperms 0755 /usr/bin/make
		dosym make /usr/bin/gmake

		dodoc AUTHORS COPYING ChangeLog NEWS README*
	else
		dobin make
	fi
}
