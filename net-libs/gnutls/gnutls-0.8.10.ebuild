# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-0.8.10.ebuild,v 1.1 2003/09/02 22:19:58 liquidx Exp $

DESCRIPTION="A TLS 1.0 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/${P}.tar.gz"

IUSE="zlib doc lzo"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-libs/libgcrypt-1.1.12
	<app-crypt/opencdk-0.5.0
	>=dev-libs/libtasn1-0.2
	zlib? ( >=sys-libs/zlib-1.1 )
	lzo? ( >=dev-libs/lzo-1.08 )"

src_unpack() {
	unpack ${A}
	# allow for custom optimisation levels
	cd ${S}; sed -i -e "s:\(CFLAGS.*\)-O2:\1:" configure
}

src_compile() {
	econf  `use_with zlib` || die
	emake || die
}

src_install() {
	einstall || die
	
	dodoc AUTHORS COPYING COPYING.LIB ChangeLog NEWS \
		README THANKS doc/TODO

	if [ "`use doc`" ] ; then
		dodoc doc/README.autoconf doc/tex/gnutls.ps
		docinto examples
		dodoc doc/examples/*.c
	fi
}
