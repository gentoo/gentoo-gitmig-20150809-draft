# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.8.ebuild,v 1.1 2004/02/17 04:23:50 mr_bones_ Exp $

DESCRIPTION="The GGZ library, used by GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="crypt ssl"

DEPEND="virtual/glibc
	crypt? ( >=dev-libs/libgcrypt-1.1.8 )
	ssl? ( dev-libs/openssl )"

src_compile() {
	local myconf=""
	use ssl && myconf="--with-tls=OpenSSL"
	econf \
		--disable-dependency-tracking \
		`use_with gcrypt` \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS Quick* README*
}
