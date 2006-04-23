# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-1.2.10-r1.ebuild,v 1.3 2006/04/23 14:00:33 flameeyes Exp $

inherit eutils gnuconfig libtool

DESCRIPTION="A TLS 1.0 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/${P}.tar.bz2"

# GPL-2 for the gnutls-extras library and LGPL for the gnutls library.
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="zlib doc crypt"

RDEPEND=">=dev-libs/libgcrypt-1.2.2
	>=app-crypt/opencdk-0.5.5
	zlib? ( >=sys-libs/zlib-1.1 )
	virtual/libc
	>=dev-libs/lzo-2
	>=dev-libs/libtasn1-0.2.11
	dev-libs/libgpg-error"
#	crypt? ( >=app-crypt/opencdk-0.5.5 )
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
	cd "${S}"

	elibtoolize
}

src_compile() {
	local myconf=""
	# use crypt || myconf="${myconf} --disable-extra-pki --disable-openpgp-authentication"

	econf  \
		`use_with zlib` \
		--without-included-minilzo \
		--without-included-libtasn1 \
		--without-included-opencdk \
		`use_enable doc gtk-doc` \
		${myconf} || die
	emake || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS \
		README THANKS doc/TODO

	if use doc ; then
		dodoc doc/README.autoconf doc/tex/gnutls.ps
		docinto examples
		dodoc doc/examples/*.c
	fi
}
