# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-0.9.4.ebuild,v 1.1 2004/06/03 07:15:32 seemant Exp $

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	dev-libs/openssl"

src_compile() {
	./config -d ${D}/usr -b ${D}/usr/bin -m ${D}/usr/man || die "configure failed"

	emake CFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	make install

	dodoc LICENSE NEWS README sample.imapfilterrc
}
