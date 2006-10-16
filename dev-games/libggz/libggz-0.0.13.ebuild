# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.13.ebuild,v 1.4 2006/10/16 17:14:47 nyhm Exp $

DESCRIPTION="The GGZ library, used by GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-amd64 ppc x86"
IUSE="crypt gnutls"
RESTRICT="test"

DEPEND="crypt? (
	>=dev-libs/libgcrypt-1.1.8
	gnutls? ( net-libs/gnutls )
	!gnutls? ( dev-libs/openssl ) )"

src_compile() {
	local tls=--with-tls=$(use gnutls && echo GnuTLS || echo OpenSSL)
	local myconf
	use crypt && myconf="${tls} --with-gcrypt" || myconf=--with-tls=no
	econf \
		--disable-dependency-tracking \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS Quick* README*
}
