# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.10.12-r1.ebuild,v 1.10 2002/12/09 04:33:19 manson Exp $

IUSE="ssl"

S=${WORKDIR}/${P}
DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/sitecopy/${P}.tar.gz"
HOMEPAGE="http://www.lyra.org/sitecopy/"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	>=dev-libs/libxml-1.8.15
        ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {
	local myconf="--enable-libxml"
	use ssl \
		&& myconf="${myconf} --with-ssl=/usr" \
		|| myconf="${myconf} --without-ssl"
	econf ${myconf}
	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr install || die "install failed"
}
