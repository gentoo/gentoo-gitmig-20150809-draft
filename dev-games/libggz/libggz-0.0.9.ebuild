# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.9.ebuild,v 1.4 2006/03/24 16:32:07 wolf31o2 Exp $

inherit eutils

DESCRIPTION="The GGZ library, used by GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="ftp://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="crypt ssl"

DEPEND="virtual/libc
	crypt? ( >=dev-libs/libgcrypt-1.1.8 )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcrypt.patch
}

src_compile() {
	local myconf=""
	use ssl && myconf="--with-tls=OpenSSL"
	econf \
		--disable-dependency-tracking \
		`use_with crypt gcrypt` \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS Quick* README*
}
