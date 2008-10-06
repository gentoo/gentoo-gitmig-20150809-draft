# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtlen/libtlen-20031114.ebuild,v 1.9 2008/10/06 05:01:32 jer Exp $

DESCRIPTION="Support library for Tlen IMS"
HOMEPAGE="http://libtlen.eu.org/"
SRC_URI="http://libtlen.eu.org/snapshots/archive/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc x86"
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
