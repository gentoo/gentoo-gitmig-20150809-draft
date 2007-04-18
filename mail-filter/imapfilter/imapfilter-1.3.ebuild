# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-1.3.ebuild,v 1.2 2007/04/18 18:26:03 opfer Exp $

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
	>=dev-lang/lua-5.0"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${PN}-1.0.patch || die "epatch failed"
}

src_compile() {
	emake MYCFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	make DESTDIR="${D}/usr" install

	dodoc LICENSE NEWS README sample.config.lua sample.extend.lua
}
