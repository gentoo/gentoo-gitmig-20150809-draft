# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.14.ebuild,v 1.3 2007/03/06 12:05:26 nyhm Exp $

inherit games-ggz

DESCRIPTION="The GGZ library, used by GGZ Gaming Zone"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE="debug gnutls"

DEPEND=">=dev-libs/libgcrypt-1.2
	gnutls? ( net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )"

src_compile() {
	games-ggz_src_compile \
		--with-gcrypt \
		--with-tls=$(use gnutls && echo GnuTLS || echo OpenSSL)
}
