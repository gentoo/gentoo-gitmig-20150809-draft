# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtlen/libtlen-20040912.ebuild,v 1.2 2005/03/27 00:55:15 luckyduck Exp $

inherit eutils

DESCRIPTION="Support library for Tlen IMS"
HOMEPAGE="http://libtlen.eu.org/"
SRC_URI="http://libtlen.eu.org/snapshots/archive/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
SLOT="0"
LICENSE="GPL-2"
IUSE="doc"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use amd64; then
		epatch ${FILESDIR}/${PV}-fPIC.patch
		aclocal
		autoconf
		libtoolize --force --copy
	fi
}

src_compile() {
	econf \
		--enable-shared || die
	emake all || die
}

src_install() {
	einstall || die
	dodoc ChangeLog
}
