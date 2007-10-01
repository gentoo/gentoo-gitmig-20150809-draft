# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-2.0.4.ebuild,v 1.2 2007/10/01 21:42:18 ticho Exp $

inherit eutils

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/openssl
	>=dev-lang/lua-5.1"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/${P}
	sed -i -e 's:/local::g' Makefile || die
}

src_compile() {
	emake MYCFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc LICENSE NEWS README sample.config.lua sample.extend.lua
}
