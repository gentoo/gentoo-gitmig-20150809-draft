# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-1.0.ebuild,v 1.5 2004/07/14 16:42:20 agriffis Exp $

inherit eutils

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	dev-libs/openssl
	dev-lang/lua"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	emake MYCFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	make DESTDIR="${D}/usr" install

	dodoc LICENSE NEWS README sample.config.lua sample.extend.lua
}
