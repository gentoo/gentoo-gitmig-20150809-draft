# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmoe/libmoe-1.5.8-r1.ebuild,v 1.1 2005/10/15 08:56:26 matsuu Exp $

inherit toolchain-funcs multilib

DESCRIPTION="multi octet character encoding handling library"
HOMEPAGE="http://pub.ks-and-ks.ne.jp/prog/libmoe/"
SRC_URI="http://pub.ks-and-ks.ne.jp/prog/pub/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	dev-lang/perl"

src_compile() {
	emake CF="${CFLAGS} -Wall -I. -fPIC" \
		LF="${LDFLAGS} -shared -Wl,-soname,\${DEST}.so.\${VER}.\${RELEASE}" \
		CC="$(tc-getCC)" || die
}

src_install() {
	make DESTDIR=${D} \
		PREFIX=/usr \
		MAN=/usr/share/man \
		LIBSODIR=/usr/$(get_libdir) \
		install || die

	dodoc ChangeLog
	dohtml libmoe.shtml
}
