# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/nikibot/nikibot-0.8.ebuild,v 1.2 2004/11/14 17:22:13 swegener Exp $

DESCRIPTION="An IRC-Bot with lua script interface"
HOMEPAGE="http://sourceforge.net/projects/nikibot/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~x86"

DEPEND="virtual/libc
	>=dev-lang/lua-5.0"

src_unpack() {
	unpack ${A}

	# Hack around wrong timestamps to avoid running automake
	touch ${S}/src/Makefile.in
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README test.lua || die "dodoc failed"
	dohtml html/* || die "dohtml failed"
}
