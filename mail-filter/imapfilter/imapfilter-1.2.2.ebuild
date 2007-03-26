# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-1.2.2.ebuild,v 1.4 2007/03/26 09:18:31 opfer Exp $

inherit eutils

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/openssl
	>=dev-lang/lua-5.0"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${PN}-1.0.patch || die "epatch failed"
	has_version ">=dev-lang/lua-5.1.1" &&
		sed -i Makefile -e 's:\(LIBS = -lm -llua\) -llualib:\1:'

}

src_compile() {
	emake MYCFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	make DESTDIR="${D}/usr" install

	dodoc LICENSE NEWS README sample.config.lua sample.extend.lua
}
