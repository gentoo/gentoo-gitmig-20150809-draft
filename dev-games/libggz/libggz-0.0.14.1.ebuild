# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.14.1.ebuild,v 1.13 2010/01/22 22:10:44 abcd Exp $

inherit games-ggz

DESCRIPTION="The GGZ library, used by GGZ Gaming Zone"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug gnutls"

DEPEND="dev-libs/libgcrypt
	gnutls? ( net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )"

src_compile() {
	games-ggz_src_compile \
		--with-gcrypt \
		--with-tls=$(use gnutls && echo GnuTLS || echo OpenSSL)
}
