# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-1.2.1.ebuild,v 1.1 2006/03/28 03:12:00 ticho Exp $

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )
	>=dev-lang/lua-5.0"

src_compile() {
	local myconf=""
	use ssl || myconf="-o ssltls=no"
	./configure -d "${D}/usr" ${myconf} || die "configure failed"
	emake MYCFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	make install

	dodoc LICENSE NEWS README sample.config.lua sample.extend.lua
}
