# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libggz/libggz-0.0.7.ebuild,v 1.1 2003/07/10 18:49:33 vapier Exp $

DESCRIPTION="The GGZ library, used by GGZ Gameing Zone"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"
HOMEPAGE="http://ggz.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"
IUSE="crypt ssl"

DEPEND="virtual/glibc
	crypt? ( dev-libs/libgcrypt )
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
