# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-1.0.17.ebuild,v 1.1 2004/08/04 13:32:56 liquidx Exp $

inherit eutils

DESCRIPTION="A TLS 1.0 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/${P}.tar.bz2"

IUSE="zlib doc crypt"
LICENSE="LGPL-2.1 | GPL-2"
# GPL-2 for the gnutls-extras library and LGPL for the gnutls library.

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~mips ~alpha ~ppc64"

RDEPEND=">=dev-libs/libgcrypt-1.1.94
	crypt? ( >=app-crypt/opencdk-0.5.3 )
	zlib? ( >=sys-libs/zlib-1.1 )
	virtual/libc"

# Need masking on ~amd64 ~sparc ~ppc ~mips ~alpha
#	>=dev-libs/libtasn1-0.2
#	>=dev-libs/lzo-1.0"

# should be crypt? ( >=app-crypt/opencdk-0.5.5 ) however I did see the source for it
# ^^ this is what configure expects.

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep
	sys-devel/gcc
	sys-devel/libtool"


# gnutls has its own version of these. should maybe avoid using.
#	libtasn1
#	opencdk

src_unpack() {
	unpack ${A}
	cd ${S}/includes/gnutls; epatch ${FILESDIR}/${PN}-1.0.14-extra.h.patch
}

src_compile() {
	#   I think this vvv gets ignored if not present
	local myconf="--without-included-libtasn1 --without-included-opencdk"


	use crypt || myconf="${myconf} --disable-extra-pki --disable-openpgp-authentication"

	econf  \
		`use_with zlib` \
		--with-included-minilzo \
		--with-included-libtasn1 \
		${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die

	# make compatibility symlinks - 0.8.x
	#dosym /usr/lib/libgnutls.so.10 /usr/lib/libgnutls.so.7

	dodoc AUTHORS COPYING COPYING.LIB ChangeLog NEWS \
		README THANKS doc/TODO

	if use doc ; then
		dodoc doc/README.autoconf doc/tex/gnutls.ps
		docinto examples
		dodoc doc/examples/*.c
	fi
}
