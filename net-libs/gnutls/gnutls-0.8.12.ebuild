# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-0.8.12.ebuild,v 1.5 2004/01/04 11:10:21 aliz Exp $

DESCRIPTION="A TLS 1.0 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/attic/${P}.tar.gz"

IUSE="zlib doc crypt"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ia64 amd64 ppc"

DEPEND=">=dev-libs/libgcrypt-1.1.12
	crypt? ( >=app-crypt/opencdk-0.5.1 )
	zlib? ( >=sys-libs/zlib-1.1 )"

# gnutls has its own version of these. so let us use those instead.
#	>=dev-libs/libtasn1-0.1
#   >=dev-libs/lzo-1.0

src_unpack() {
	unpack ${A}
	# allow for custom optimisation levels
	cd ${S}; sed -i -e "s:\(CFLAGS.*\)-O2:\1:" configure
}

src_compile() {
	local myconf

	use crypt || myconf="${myconf} --disable-openpgp-authentication"

	econf  \
		`use_with zlib` \
		--with-included-minilzo \
		--with-included-libtasn1 \
		${myconf} || die
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
