# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmoe/libmoe-1.5.8.ebuild,v 1.3 2005/03/07 17:54:56 gustavoz Exp $

inherit toolchain-funcs

DESCRIPTION="multi octet character encoding handling library"
HOMEPAGE="http://pub.ks-and-ks.ne.jp/prog/libmoe/"
SRC_URI="http://pub.ks-and-ks.ne.jp/prog/pub/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~ppc sparc -alpha"
IUSE=""

DEPEND="virtual/libc
	dev-lang/perl"

src_compile() {
	emake CF="${CFLAGS} -I." \
		LF="${LDFLAGS} -shared"\
		CC="$(tc-getCC)" || die
}

src_install() {
	make DESTDIR=${D} \
		PREFIX=/usr \
		MAN=/usr/share/man \
		install-lib install-man || die

	exeinto /usr/bin
	doexe  mbconv

	dolib.so libmoe.so.${PV} || die
	dosym /usr/lib/libmoe.so.${PV} /usr/lib/libmoe.so.${PV%%.*}
	dosym /usr/lib/libmoe.so.${PV} /usr/lib/libmoe.so.${PV%.*}
	dosym /usr/lib/libmoe.so.${PV} /usr/lib/libmoe.so

	dodoc ChangeLog libmoe.shtml
}
