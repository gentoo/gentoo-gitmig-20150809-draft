# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.10.12-r1.ebuild,v 1.13 2003/09/05 22:01:49 msterret Exp $

DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/sitecopy/${P}.tar.gz"
HOMEPAGE="http://www.lyra.org/sitecopy/"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2"
SLOT="0"

IUSE="ssl"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	>=dev-libs/libxml-1.8.15
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {
	local myconf="--enable-libxml"

	if [ `use ssl` ] ; then
		myconf="${myconf} --with-ssl=/usr"
	else
		myconf="${myconf} --without-ssl"
	fi
	econf ${myconf} || die "configure problem"
	mv Makefile Makefile.orig
	sed <Makefile.orig >Makefile \
		-e 's|man1dir = /usr/share/man/man1|man1dir = $(prefix)/share/man/man1|'
	emake || die "compile problem"
}

src_install() {
	einstall || die "install problem"
}
