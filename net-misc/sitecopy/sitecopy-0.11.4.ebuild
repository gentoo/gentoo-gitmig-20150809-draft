# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.11.4.ebuild,v 1.4 2003/09/05 22:01:49 msterret Exp $

DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/sitecopy/${P}.tar.gz"
HOMEPAGE="http://www.lyra.org/sitecopy/"
KEYWORDS="x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"

IUSE="ssl"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	>=dev-libs/libxml-1.8.15
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {
	local myconf="--with-libxml1"

	if [ `use ssl` ] ; then
		myconf="${myconf} --with-ssl=/usr"
	else
		myconf="${myconf} --without-ssl"
	fi
	econf ${myconf}
	emake || die "compile problem"
}

src_install() {
	einstall || die "install problem"
}
