# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.7.ebuild,v 1.3 2004/02/17 04:23:50 mr_bones_ Exp $

DESCRIPTION="The GGZ library, used by GGZ Gameing Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

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
		`use_with gcrypt` \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS Quick* README*
}
