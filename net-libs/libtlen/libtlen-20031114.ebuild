# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtlen/libtlen-20031114.ebuild,v 1.8 2005/03/27 00:55:15 luckyduck Exp $

DESCRIPTION="Support library for Tlen IMS"
HOMEPAGE="http://libtlen.eu.org/"
SRC_URI="http://libtlen.eu.org/snapshots/archive/${P}.tar.gz"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf \
		--enable-shared || die
	emake CFLAGS="${CFLAGS}" all || die
}

src_install() {
	einstall || die
	dodoc ChangeLog
}
